import Foundation
import CoreData

struct TrackerStoreUpdate {
    let insertedIndexes: IndexSet
    let deletedIndexes: IndexSet
}

final class TrackerStore: NSObject, TrackerStoreProtocol {
    
    weak var delegate: TrackerStoreDelegate?
    
    let coreDataManager = CoreDataManager.defaultManager
    lazy var context = coreDataManager.persistentContainer.viewContext
    lazy var colorMarshalling = UIColorMarshalling()
    
    var visibleCategories: [TrackerCategory] {
        let visibleCategories = self.fetchTrackers()
        return visibleCategories
    }
    
    private var insertedIndexes: IndexSet?
    private var deletedIndexes: IndexSet?
    
    private lazy var fetchedResultController: NSFetchedResultsController<TrackerCoreData> = {
        let request = NSFetchRequest<TrackerCoreData>(entityName: "TrackerCoreData")
        request.sortDescriptors = [NSSortDescriptor(key: "category.name", ascending: true)]
        
        let fetchController = NSFetchedResultsController(fetchRequest: request,
                                                         managedObjectContext: context,
                                                         sectionNameKeyPath: "category.name",
                                                         cacheName: nil)
        fetchController.delegate = self
        
        do {
            try fetchController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        
        return fetchController
    }()
    
    func addTracker(tracker: Tracker, selectedCategory: String) {
        let trackerCoreData = TrackerCoreData(context: context)
        let color = colorMarshalling.convertRGBColorToHex(from: tracker.color)
        
        trackerCoreData.name = tracker.name
        trackerCoreData.id = tracker.id
        trackerCoreData.schedule = tracker.schedule
        trackerCoreData.emoji = tracker.emoji
        trackerCoreData.color = color
        trackerCoreData.isPinned = tracker.isPinned
        
        let category = coreDataManager.trackerCategoryStore?.getCategory(byName: selectedCategory)
        
        trackerCoreData.category = category
        
        coreDataManager.saveContext()
    }
    
    func fetchTrackers() -> [TrackerCategory] {
        guard let sections = fetchedResultController.sections else { return [] }
        
        var categories: [TrackerCategory] = []
        for section in sections {
            guard let object = section.objects as? [TrackerCoreData] else { return [] }
            
            
            var listOfTrackers: [Tracker] = []
            
            for tracker in object {
                let color = colorMarshalling.convertHexColorToRGB(from: tracker.color ?? "")
                listOfTrackers.append(Tracker(id: tracker.id ?? UUID(),
                                              color: color,
                                              emoji: tracker.emoji ?? "",
                                              name: tracker.name ?? "",
                                              isPinned: tracker.isPinned,
                                              schedule: tracker.schedule))
                
            }
            var category = TrackerCategory(name: section.name, listOfTrackers: listOfTrackers)
            categories.append(category)
        }
        
        return updateCategoriesWithPinnedTrackers(categories: categories)
    }
    
    func deleteTracker(with id: UUID) {
        guard let object = fetchedResultController.fetchedObjects?.first(where: {
            trackerCoreData in
            trackerCoreData.id == id
        }) else { return }
        
        context.delete(object)
        coreDataManager.saveContext()
    }
    
    func pinTracker(id: UUID) {
        guard let object = fetchedResultController.fetchedObjects?.first(where: {
            trackerCoreData in
            trackerCoreData.id == id
        }) else { return }
        
        object.isPinned = true
        coreDataManager.saveContext()
    }
    
    func unpinTracker(id: UUID) {
        guard let object = fetchedResultController.fetchedObjects?.first(where: {
            trackerCoreData in
            trackerCoreData.id == id
        }) else { return }
        
        object.isPinned = false
        coreDataManager.saveContext()
    }
    
    func updateCategoriesWithPinnedTrackers(categories: [TrackerCategory]) -> [TrackerCategory] {
        var updatedCategories = categories
        var pinnedTrackers: [Tracker] = []
        
        for (index, category) in updatedCategories.enumerated() {
            let pinned = category.listOfTrackers.filter { $0.isPinned }
            
            updatedCategories[index].listOfTrackers = category.listOfTrackers.filter { !$0.isPinned }
            
            pinnedTrackers.append(contentsOf: pinned)
        }
        
        let pinnedCategory = TrackerCategory(name: NSLocalizedString("pinned", comment: ""), listOfTrackers: pinnedTrackers)
        
        updatedCategories.insert(pinnedCategory, at: 0)
        
        return updatedCategories
    }
}

extension TrackerStore: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        insertedIndexes = IndexSet()
        deletedIndexes = IndexSet()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let insertedSet = insertedIndexes,
              let deletedSet = deletedIndexes else { return }
        
        delegate?.store(self, didUpdate: TrackerStoreUpdate(insertedIndexes: insertedSet, deletedIndexes: deletedSet))
        insertedIndexes = nil
        deletedIndexes = nil
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .delete:
            if let indexPath = indexPath {
                deletedIndexes?.insert(indexPath.item)
            }
        case .insert:
            if let indexPath = newIndexPath {
                insertedIndexes?.insert(indexPath.item)
            }
        default:
            break
        }
    }
}


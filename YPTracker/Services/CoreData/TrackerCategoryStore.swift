import Foundation
import CoreData



final class TrackerCategoryStore: NSObject, TrackerCategoryStoreProtocol {
    
    var delegate: TrackerCategoryStoreDelegate?
    
    private let coreDataManager = CoreDataManager.defaultManager
    private lazy var context = coreDataManager.persistentContainer.viewContext
    
    private lazy var fetchedResultController: NSFetchedResultsController<TrackerCategoryCoreData> = {
        let request = NSFetchRequest<TrackerCategoryCoreData>(entityName: "TrackerCategoryCoreData")
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        let fetchController = NSFetchedResultsController(fetchRequest: request,
                                                         managedObjectContext: context,
                                                         sectionNameKeyPath: nil,
                                                         cacheName: nil)
        fetchController.delegate = self
        
        do {
            try fetchController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        
        return fetchController
    }()
    
    func getCategory(byName name: String) -> TrackerCategoryCoreData {
        let request = TrackerCategoryCoreData.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        
        if let categoryTracker = try? context.fetch(request).first {
            
            return categoryTracker
        } else {
            let newCategoryTracker = TrackerCategoryCoreData(context: context)
            newCategoryTracker.name = name
            return newCategoryTracker
        }
    }
    
    func getCategoriesNames() -> [String] {
        guard let categories = fetchedResultController.fetchedObjects else { return []}
        var categoriesNames: [String] = []
        
        for item in categories {
            if let name = item.name {
                categoriesNames.append(name)
            }
        }
        return categoriesNames
    }
    
    func addCategory(with name: String) {
        let trackerCategoryCoreData = TrackerCategoryCoreData(context: context)
        
        trackerCategoryCoreData.name =  name
        coreDataManager.saveContext()
        
    }
    
    func deleteCategory() {
        
    }
}

extension TrackerCategoryStore: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.fetchVisibleCategories()
    }
}

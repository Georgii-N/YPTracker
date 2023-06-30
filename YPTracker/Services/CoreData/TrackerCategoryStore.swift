import Foundation
import CoreData



final class TrackerCategoryStore: NSObject, TrackerCategoryStoreProtocol {
    
    let coreDataManager = CoreDataManager.defaultManager
    lazy var context = coreDataManager.persistentContainer.viewContext
    
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
    
    func deleteCategory() {
        
    }
}

extension TrackerCategoryStore: NSFetchedResultsControllerDelegate {
    
}

import CoreData
import UIKit

final class CoreDataManager {
    static let defaultManager = CoreDataManager()
    var trackerStore: TrackerStoreProtocol?
    var trackerCategoryStore: TrackerCategoryStoreProtocol?
    var trackerRecordStore: TrackerRecordStoreProtocol?
    
    private init() {
    }
    
    // MARK: - Core Data stack
    
    let persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "TrackersCoreDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                assertionFailure("Unresolved error \(error), \(error.userInfo)")
            }
        })
        // container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                assertionFailure("Ошибка при сохранении контекста Core Data: \(error), \(error.localizedDescription)")
            }
        }
    }
}

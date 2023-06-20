import Foundation
import CoreData

final class TrackerRecordStore: NSObject, TrackerRecordStoreProtocol {
    let coreDataManager = CoreDataManager.defaultManager
    lazy var context = coreDataManager.persistentContainer.viewContext
    
    private lazy var fetchedResultController: NSFetchedResultsController<TrackerRecordCoreData> = {
           let request = NSFetchRequest<TrackerRecordCoreData>(entityName: "TrackerRecordCoreData")
           request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
           
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
    
    func addRecord() {
        
    }
    
    func getRecord() {
        
    }
    
}

extension TrackerRecordStore: NSFetchedResultsControllerDelegate {
    
}

import Foundation
import CoreData

final class TrackerRecordStore: NSObject, TrackerRecordStoreProtocol {
    
    var delegate: TrackerRecordStoreDelegate?
    
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
    
    func addTrackerRecord(tracker: TrackerRecord) {
        
        let trackerRecord = TrackerRecordCoreData(context: context)
        
        trackerRecord.id = tracker.id
        trackerRecord.date = tracker.date
        coreDataManager.saveContext()
    }
    
    func getTrackersRecord() -> [TrackerRecord] {
        
        guard let trackerRecords = fetchedResultController.fetchedObjects else { return [] }
        var newTrackersRecord: [TrackerRecord] = []
        
        for trackerRecord in trackerRecords {
            newTrackersRecord.append(TrackerRecord(id: trackerRecord.id ?? UUID(), date: trackerRecord.date ?? Date()))
        }
        
        return newTrackersRecord
    }
    
    func deleteTrackerRecord(with id: UUID, and currentDate: Date) {
        let request: NSFetchRequest<TrackerRecordCoreData> = TrackerRecordCoreData.fetchRequest()
//        let calendar = Calendar.current
//        let currentDateComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)
//        print("PRINT: currentDateComponents \(currentDateComponents)")
        
        request.predicate = NSPredicate(format: "id == %@ AND date == %@", id as CVarArg, currentDate as CVarArg)
        
        do {
            let results = try context.fetch(request)
            
            if let recordToDelete = results.first {
                context.delete(recordToDelete)
                coreDataManager.saveContext()
            }
        } catch {
            print("Error deleting tracker record: \(error)")
        }
    }
}

extension TrackerRecordStore: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.getTrackersRecordFromStore()
        delegate?.showActualTrackers()
    }
}

import Foundation
protocol TrackerRecordStoreProtocol {
    var delegate: TrackerRecordStoreDelegate? { get set }
    
    func addTrackerRecord(tracker: TrackerRecord)
    func getTrackersRecord() -> [TrackerRecord]
    func deleteTrackerRecord(with id: UUID, and currentDate: Date)
}

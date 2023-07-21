import Foundation

protocol TrackerRecordStoreDelegate: AnyObject {
    func getTrackersRecordFromStore()
    func showActualTrackers()
}

protocol TrackerRecordStoreStatisticDelegate: AnyObject {
    func updateCount()
}

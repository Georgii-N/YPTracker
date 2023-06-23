import Foundation

protocol TrackerRecordStoreDelegate: AnyObject {
    func getTrackersRecordFromStore()
    func showActualTrackers()
}

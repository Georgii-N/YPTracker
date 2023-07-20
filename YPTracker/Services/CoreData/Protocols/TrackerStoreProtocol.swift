import Foundation
protocol TrackerStoreProtocol {
    var visibleCategories: [TrackerCategory] { get }
    var delegate: TrackerStoreDelegate? { get set }
    func fetchTrackers() -> [TrackerCategory]
    func addTracker(tracker: Tracker, selectedCategory: String)
    func pinTracker(id: UUID)
    func unpinTracker(id: UUID)
    func deleteTracker(with id: UUID)
}

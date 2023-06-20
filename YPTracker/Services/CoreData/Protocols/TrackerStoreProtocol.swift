import Foundation
protocol TrackerStoreProtocol {
    var visibleCategories: [TrackerCategory] { get }
    var delegate: TrackerStoreDelegate? { get set }
    func fetchTrackers() -> [TrackerCategory]
    func addTracker(tracker: Tracker, selectedCategory: String)
}

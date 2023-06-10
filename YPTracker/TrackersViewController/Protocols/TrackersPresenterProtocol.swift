import Foundation

protocol TrackersPresenterProtocol {
    var view: TrackersViewControllerProtocol? { get set }
    var currentDate: Date?  { get set }
    var visibleCategories: [TrackerCategory]?  { get set }
    func updateVisibleCategories()
    func setupCurrentDate(date: Date)
    func createTrackerRecord(with id: UUID) -> String
    func filterArray(for searchText: String)
    func setDateFromDataPicker()
    func filterByDate()
}

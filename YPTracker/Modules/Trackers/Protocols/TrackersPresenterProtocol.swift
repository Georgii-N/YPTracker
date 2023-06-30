import Foundation

protocol TrackersPresenterProtocol {
    var view: TrackersViewControllerProtocol? { get set }
    var currentDate: Date?  { get set }
    var visibleCategories: [TrackerCategory]?  { get set }
    
    func setupCurrentDate(date: Date)
    func checkCurrentDateIsTodayDate() -> Bool
    func createOrDeleteTrackerRecord(with id: UUID)
    func filterArray(for searchText: String)
    func filterByDate()
    func checkTrackerCompletedForCurrentData(id: UUID) -> Bool
    func countOfCompletedDays(id: UUID) -> String
    func checkVisibleTrackersAfterFilter(by filter: TypeOfStub)
}

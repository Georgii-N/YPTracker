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
    
    func pinTracker(id: UUID)
    func unpinTracker(id: UUID)
    func deleteTracker(id: UUID)
    func editTracker(id: UUID, category: String)
    
    func resetAllfilters()
    func filterByToday()
    func filterCompletedTracker()
    func filterUncompletedTracker()
    
    func getCurrentFilter() -> Int
}

import Foundation

final class TrackersPresenter: TrackersPresenterProtocol {
    
    private let coreDataManager = CoreDataManager.defaultManager
    
    weak var view: TrackersViewControllerProtocol?
    var currentDate: Date?
    
    var visibleCategories: [TrackerCategory]?
    var completedTrackers: [TrackerRecord]?
    
    init() {
        coreDataManager.trackerStore = TrackerStore()
        coreDataManager.trackerCategoryStore = TrackerCategoryStore()
        coreDataManager.trackerRecordStore = TrackerRecordStore()
        coreDataManager.trackerStore?.delegate = self
        coreDataManager.trackerRecordStore?.delegate = self
        getVisibleTrackersFromStorage()
        getTrackersRecordFromStore()
    }
    
    func getVisibleTrackersFromStorage() {
        visibleCategories = coreDataManager.trackerStore?.visibleCategories
    }
    
    func setupCurrentDate(date: Date) {
        currentDate = date
        filterByDate()
    }
    
    func checkCurrentDateIsTodayDate() -> Bool  {
        guard let currentDate = currentDate else { return false }
        let date = Date()
        return date > currentDate ? true : false
    }
    
    func filterByDate() {
        getVisibleTrackersFromStorage()
        var filteredCategories = [TrackerCategory]()
        
        guard let date = currentDate,
              let visibleCategories = visibleCategories else { return }
        let calendar = Calendar.current
        var weekday = calendar.component(.weekday, from: date)
        weekday = (weekday + 5) % 7
        
        
        //MARK: УМЕНЬШИТЬ СЛОЖНОСТЬ АЛГОРИТМА
        for category in visibleCategories {
            var trackers = [Tracker]()
            for tracker in category.listOfTrackers {
                guard let schedule = tracker.schedule else { return }
                if schedule.contains(weekday) {
                    trackers.append(tracker)
                } else if schedule.isEmpty {
                    trackers.append(tracker)
                }
            }
            
            if !trackers.isEmpty {
                let trackerCategory = TrackerCategory(name: category.name, listOfTrackers: trackers)
                filteredCategories.append(trackerCategory)
            }
        }
        self.visibleCategories = filteredCategories
        checkVisibleTrackersAfterFilter(by: .dateFilter)
        view?.showActualTrackers()
    }
    
    func createOrDeleteTrackerRecord(with id: UUID) {
        guard let currentDate = currentDate,
              let completedTrackers = completedTrackers
        else { return }
        
        let trackerRecord = TrackerRecord(id: id, date: currentDate)
        
        if (completedTrackers.firstIndex(of: trackerRecord) != nil) {
            coreDataManager.trackerRecordStore?.deleteTrackerRecord(with: id, and: currentDate)
            getTrackersRecordFromStore()
        } else {
            coreDataManager.trackerRecordStore?.addTrackerRecord(tracker: trackerRecord)
            getTrackersRecordFromStore()
        }
    }
    
    func countOfCompletedDays(id: UUID) -> String {
        let count =
        completedTrackers == nil ?
        0 : completedTrackers!.filter { $0.id == id }.count
        return formatDaysString(count)
    }
    
    func formatDaysString(_ n: Int) -> String {
        var daysString: String
        
        if n == 0 {
            daysString = "0 дней"
        } else {
            daysString = "\(n) дней"
            
            let lastDigit = n % 10
            let lastTwoDigits = n % 100
            
            if lastTwoDigits >= 11 && lastTwoDigits <= 19 {
                
                return daysString
            } else if lastDigit == 1 {
                
                daysString = "\(n) день"
            } else if lastDigit >= 2 && lastDigit <= 4 {
                daysString = "\(n) дня"
            }
        }
        
        return daysString
    }
    
    func filterArray(for searchText: String) {
        if !searchText.isEmpty {
            let filteredArray = visibleCategories?.filter { category in
                let filteredTrackers = category.listOfTrackers.filter { tracker in
                    
                    return tracker.name.lowercased().contains(searchText.lowercased())
                }
                return !filteredTrackers.isEmpty
            }
            visibleCategories = filteredArray
        } else {
            getVisibleTrackersFromStorage()
        }
        checkVisibleTrackersAfterFilter(by: .searchFilter)
        view?.showActualTrackers()
    }
    
    func checkTrackerCompletedForCurrentData(id: UUID) -> Bool {
        guard let completedTrackers = completedTrackers,
              let currentDate = currentDate else { return false }
        
        if completedTrackers.contains(TrackerRecord(id: id, date: currentDate)) {
            return true
        } else {
            return false
        }
    }
    
    func checkVisibleTrackersAfterFilter(by filter: TypeOfStub) {
        guard let visibleCategories = visibleCategories else { return }
        if visibleCategories.count == 0 {
            view?.showStub(after: filter)
        } else {
            view?.hideStub()
        }
    }
}

extension TrackersPresenter: TrackerStoreDelegate {
    func store(_ store: TrackerStore, didUpdate update: TrackerStoreUpdate) {
        getVisibleTrackersFromStorage()
        checkVisibleTrackersAfterFilter(by: .dateFilter)
        filterByDate()
        view?.showActualTrackers()
    }
}

extension TrackersPresenter: TrackerRecordStoreDelegate {
    func getTrackersRecordFromStore() {
        completedTrackers = coreDataManager.trackerRecordStore?.getTrackersRecord()
        
    }
    
    func showActualTrackers() {
        view?.showActualTrackers()
    }
}

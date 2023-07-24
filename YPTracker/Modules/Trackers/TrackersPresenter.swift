import Foundation

final class TrackersPresenter: TrackersPresenterProtocol {
    
    private let coreDataManager = CoreDataManager.defaultManager
    
    weak var view: TrackersViewControllerProtocol?
    var currentDate: Date?
    var currentFilter = 1
    
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
    
    func pinTracker(id: UUID) {
        coreDataManager.trackerStore?.pinTracker(id: id)
    }
    
    func unpinTracker(id: UUID) {
        coreDataManager.trackerStore?.unpinTracker(id: id)
    }
    
    func deleteTracker(id: UUID) {
        coreDataManager.trackerStore?.deleteTracker(id: id)
    }
    
    func getCurrentFilter() -> Int {
        currentFilter
    }
    
    func editTracker(id: UUID, category: String) {
        guard let tracker = coreDataManager.trackerStore?.getTracker(id: id) else { return }
        let classtype: TypeOfEvent = tracker.schedule == nil ? .irregular : .regular
        let editViewController = CreateTrackerViewController(classType: classtype)
        let presenter = CreateTrackerPresenter()
        editViewController.presenter = presenter
        
        presenter.view = editViewController
        presenter.trackerName = tracker.name
        presenter.selectedCategory = category
        presenter.trackerSchedule = tracker.schedule
        presenter.trackerColor = tracker.color
        presenter.trackerEmoji = tracker.emoji
        presenter.idTracker = tracker.id
        presenter.trackerRecord = countOfCompletedDays(id: tracker.id)
        
        editViewController.isEdit = true
        
        view?.showEditViewController(vc: editViewController)
    }
    
    
    func checkCurrentDateIsTodayDate() -> Bool  {
        guard let currentDate = currentDate else { return false }
        let date = Date()
        return date > currentDate ? true : false
    }
    
    func resetAllfilters() {
        currentFilter = 0
        getVisibleTrackersFromStorage()
        view?.showActualTrackers()
    }
    
    func filterByToday() {
        currentFilter = 1
        filterByDate()
    }
    
    func filterCompletedTracker() {
        currentFilter = 2
        getVisibleTrackersFromStorage()
        getTrackersRecordFromStore()
        guard var visibleCategories = visibleCategories else { return }
        var categoriesToRemove: [Int] = []
        
        for categoryIndex in visibleCategories.indices {
            var category = visibleCategories[categoryIndex]
            
            let filteredTrackers = category.listOfTrackers.filter { tracker in
                return checkTrackerCompletedForCurrentData(id: tracker.id)
            }
            category.listOfTrackers = filteredTrackers
            
            if category.listOfTrackers.isEmpty {
                categoriesToRemove.append(categoryIndex)
            }
            
            visibleCategories[categoryIndex] = category
        }
        
        for index in categoriesToRemove.sorted(by: >) {
            visibleCategories.remove(at: index)
        }
        self.visibleCategories = visibleCategories
        view?.showActualTrackers()
    }
    
    func filterUncompletedTracker() {
        currentFilter = 3
        getVisibleTrackersFromStorage()
        getTrackersRecordFromStore()
        guard var visibleCategories = visibleCategories else { return }
        
        var categoriesToRemove: [Int] = []
        for categoryIndex in visibleCategories.indices {
            var category = visibleCategories[categoryIndex]
            
            let filteredTrackers = category.listOfTrackers.filter { tracker in
                return !checkTrackerCompletedForCurrentData(id: tracker.id)
            }
            
            category.listOfTrackers = filteredTrackers
            
            if category.listOfTrackers.isEmpty {
                categoriesToRemove.append(categoryIndex)
            }
            
            visibleCategories[categoryIndex] = category
        }
        for index in categoriesToRemove.sorted(by: >) {
            visibleCategories.remove(at: index)
        }
        
        self.visibleCategories = visibleCategories
        view?.showActualTrackers()
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
        view?.showActualTrackers()
    }
    
    func countOfCompletedDays(id: UUID) -> String {
        let count =
        completedTrackers == nil ?
        0 : completedTrackers!.filter { $0.id == id }.count
        let tasksString = String.localizedStringWithFormat(
            NSLocalizedString("numberOfDays", comment: "Number of remaining tasks"), count)
        return tasksString
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

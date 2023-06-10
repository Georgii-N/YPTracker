import Foundation

final class TrackersPresenter: TrackersPresenterProtocol {
    weak var view: TrackersViewControllerProtocol?
    var currentDate: Date?
    var visibleCategories: [TrackerCategory]?
    
    
    func setDateFromDataPicker() {
        
    }
    
    func updateVisibleCategories() {
        visibleCategories = StorageSingleton.storage.categories
    }
    
    func setupCurrentDate(date: Date) {
        currentDate = date
        filterByDate()
    }
    
    func filterByDate() {
        updateVisibleCategories()
        print("ПРИНТ \(currentDate), \(visibleCategories)")
        var filteredCategories = [TrackerCategory]()
        
        guard let date = currentDate,
        let visibleCategories = visibleCategories else { return }
        let calendar = Calendar.current
        var weekday = calendar.component(.weekday, from: date)
        weekday = (weekday + 5) % 7
        
        
        //MARK: УМЕНЬШИТЬТ СЛОЖНОСТЬ АЛГОРИТМА
        for category in visibleCategories {
            var trackers = [Tracker]()
            print("ПРИНТ category.name \(category.name)")
            for tracker in category.listOfTrackers {
                guard let schedule = tracker.schedule else { return }
                print("ПРИНТ weekday \(weekday), tracker.schedule \(tracker.schedule) ")
                if schedule.contains(weekday) {
                    trackers.append(tracker)
                    print("ПРИНТ trackers \(trackers)")
                } else if schedule.isEmpty {
                    trackers.append(tracker)
                }
            }
            
            if !trackers.isEmpty {
                let trackerCategory = TrackerCategory(name: category.name, listOfTrackers: trackers)
                filteredCategories.append(trackerCategory)
                print("ПРИНТ filteredCategories \(filteredCategories)")
            }
        }
        self.visibleCategories = filteredCategories
        view?.updateCollectionView()
    }
    
    func createTrackerRecord(with id: UUID) -> String {
        guard let date = currentDate
        else { return ""}
        let trackerRecord = TrackerRecord(id: id, date: date)
        if var completedTrackers = StorageSingleton.storage.completedTrackers {
            if let index = completedTrackers.firstIndex(of: trackerRecord) {
                completedTrackers.remove(at: index)
            } else {
                completedTrackers.append(trackerRecord)
            }
            StorageSingleton.storage.completedTrackers = completedTrackers
        } else {
            let completedTrackers = [trackerRecord]
            StorageSingleton.storage.completedTrackers = completedTrackers
        }
        
        let count =
        StorageSingleton.storage.completedTrackers == nil ?
        0 : StorageSingleton.storage.completedTrackers!.filter { $0.id == id }.count
        
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
            visibleCategories = StorageSingleton.storage.categories
        }
        view?.updateCollectionView()
    }
    
}

extension TrackersPresenter: GreatTrackerControllerDelegateProtocol {
    func refreshTrackersCollectionView() {
        updateVisibleCategories()
        view?.updateCollectionView()
    }
}



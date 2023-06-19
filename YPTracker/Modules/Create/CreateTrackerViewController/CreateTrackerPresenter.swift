import UIKit

final class CreateTrackerPresenter: CreateTrackerPresenterProtocol {
    weak var view: CreateTrackerViewControllerProtocol?
    var emojiArray = [
        "🙂", "😻", "🌺", "🐶", "❤️", "😱",
        "😇", "😡", "🥶", "🤔", "🙌", "🍔",
        "🥦", "🏓", "🥇", "🎸", "🏝", "😪"
    ]
    
    var colorArray = [
        R.Colors.ColorsForCollection.colorCollection1,
        R.Colors.ColorsForCollection.colorCollection2,
        R.Colors.ColorsForCollection.colorCollection3,
        R.Colors.ColorsForCollection.colorCollection4,
        R.Colors.ColorsForCollection.colorCollection5,
        R.Colors.ColorsForCollection.colorCollection6,
        R.Colors.ColorsForCollection.colorCollection7,
        R.Colors.ColorsForCollection.colorCollection8,
        R.Colors.ColorsForCollection.colorCollection9,
        R.Colors.ColorsForCollection.colorCollection10,
        R.Colors.ColorsForCollection.colorCollection11,
        R.Colors.ColorsForCollection.colorCollection12,
        R.Colors.ColorsForCollection.colorCollection13,
        R.Colors.ColorsForCollection.colorCollection14,
        R.Colors.ColorsForCollection.colorCollection15,
        R.Colors.ColorsForCollection.colorCollection16,
        R.Colors.ColorsForCollection.colorCollection17,
        R.Colors.ColorsForCollection.colorCollection18
    ]
    
    func checkAndOpenCreateButton() {
        if StorageSingleton.storage.trackerName != nil &&
            StorageSingleton.storage.trackerColor != nil &&
            StorageSingleton.storage.trackerEmoji != nil &&
            StorageSingleton.storage.selectedCategory != nil {
            switch view?.titlesFotTableView.count {
            case 1:
                view?.unlockCreateButton()
            case 2:
                StorageSingleton.storage.trackerSchedule != nil ? view?.unlockCreateButton() : view?.lockCreateButton()
            default:
                view?.lockCreateButton()
            }
        } else {
            view?.lockCreateButton()
        }
    }
    
    func updateCreateTrackerSchedule() {
        guard let array = StorageSingleton.storage.trackerSchedule  else { return }
        let string = StorageSingleton.storage.trackerScheduleToString(indexes: array)
        view?.selectedTitles[1] = string
        view?.reloadTableView()
    }
    
    func greateNewTracker() -> [TrackerCategory] {
        guard
            let trackerName = StorageSingleton.storage.trackerName,
            let selectedCategory = StorageSingleton.storage.selectedCategory,
            let trackerColor = StorageSingleton.storage.trackerColor,
            let trackerEmoji = StorageSingleton.storage.trackerEmoji
        else { return []}
        let categories = StorageSingleton.storage.categories
        
        let tracker = Tracker(id: UUID(),
                              color: trackerColor,
                              emoji: trackerEmoji,
                              name: trackerName,
                              schedule: StorageSingleton.storage.trackerSchedule ?? [])
        var newCategories: [TrackerCategory] = []
        
        categories.forEach { category in
            if selectedCategory == category.name {
                var newTrackersArray = category.listOfTrackers
                newTrackersArray.append(tracker)
                newCategories.append(TrackerCategory(name: category.name, listOfTrackers: newTrackersArray))
            } else {
                newCategories.append(category)
            }
        }
        return newCategories
    }
}

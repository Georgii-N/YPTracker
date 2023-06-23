import UIKit

final class CreateTrackerPresenter: CreateTrackerPresenterProtocol {
    weak var view: CreateTrackerViewControllerProtocol?
    
    let coreDataManager = CoreDataManager.defaultManager
    
    var selectedCategory: String?
    var trackerName: String?
    var trackerColor: UIColor?
    var trackerEmoji: String?
    var trackerSchedule: [Int]?
    
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
        if trackerName != nil &&
            trackerColor != nil &&
            trackerEmoji != nil &&
            selectedCategory != nil {
            switch view?.titlesFotTableView.count {
            case 1:
                view?.unlockCreateButton()
            case 2:
                trackerSchedule != nil ? view?.unlockCreateButton() : view?.lockCreateButton()
            default:
                view?.lockCreateButton()
            }
        } else {
            view?.lockCreateButton()
        }
    }
    
    func updateCreateTrackerSchedule(with indexesOfDays: [Int]) {
        self.trackerSchedule = indexesOfDays
        let string = trackerScheduleToString(indexes: self.trackerSchedule ?? [])
        view?.selectedTitles[1] = string
        view?.reloadTableView()
    }
    
    func greateNewTracker() {
        guard
            let trackerName = trackerName,
            let selectedCategory = selectedCategory,
            let trackerColor = trackerColor,
            let trackerEmoji = trackerEmoji
        else { return }
        
        let tracker = Tracker(id: UUID(), color: trackerColor, emoji: trackerEmoji, name: trackerName, schedule: trackerSchedule ?? [0,1,2,3,4,5,6])
        
        coreDataManager.trackerStore?.addTracker(tracker: tracker, selectedCategory: selectedCategory)
    }
    
    func trackerScheduleToString(indexes: [Int]) -> String {
        var shortenedNames = [String]()
        for index in indexes {
            switch index {
            case 0:
                shortenedNames.append("Пн")
            case 1:
                shortenedNames.append("Вт")
            case 2:
                shortenedNames.append("Ср")
            case 3:
                shortenedNames.append("Чт")
            case 4:
                shortenedNames.append("Пт")
            case 5:
                shortenedNames.append("Сб")
            case 6:
                shortenedNames.append("Вс")
            default:
                shortenedNames.append("Пн")
            }
        }
        
        return shortenedNames.joined(separator: ", ")
    }
    
    func clearNewTrackerVars() {
        trackerName = nil
        selectedCategory = nil
        trackerSchedule = nil
        trackerEmoji = nil
        trackerColor = nil
    }
}

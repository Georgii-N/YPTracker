import UIKit

final class CreateTrackerPresenter: CreateTrackerPresenterProtocol {
    weak var view: CreateTrackerViewControllerProtocol?
    
    var selectedCategoryString: String?
    var selectedScheduleString: String?
    
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
}

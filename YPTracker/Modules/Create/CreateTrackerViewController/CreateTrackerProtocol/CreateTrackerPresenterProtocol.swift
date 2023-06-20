import UIKit
protocol CreateTrackerPresenterProtocol {
    var view: CreateTrackerViewControllerProtocol? { get set }
    var emojiArray: [String] { get }
    var colorArray: [UIColor] { get }
    var selectedCategory: String? { get set }
    var trackerName: String? { get set }
    var trackerColor: UIColor? { get set }
    var trackerEmoji: String? { get set }
    var trackerSchedule: [Int]? { get set }
    
    func clearNewTrackerVars()
    func checkAndOpenCreateButton()
    func updateCreateTrackerSchedule(with indexesOfDays: [Int])
    func greateNewTracker()
    
}

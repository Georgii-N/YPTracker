import UIKit
protocol CreateTrackerPresenterProtocol {
    var view: CreateTrackerViewControllerProtocol? { get set }
    var emojiArray: [String] { get }
    var colorArray: [UIColor] { get }
    
    func checkAndOpenCreateButton()
    func updateCreateTrackerSchedule()
    func greateNewTracker() -> [TrackerCategory]
}

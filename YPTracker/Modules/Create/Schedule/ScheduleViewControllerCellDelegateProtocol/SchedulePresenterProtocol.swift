import Foundation

protocol SchedulePresenterProtocol {
    var view: ScheduleViewControllerProtocol? { get set }
    var weekDays: [String] { get set }
    var selectedIndexes: [Int] { get set }
    func setupSchedule()
}

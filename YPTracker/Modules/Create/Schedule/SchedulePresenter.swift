import Foundation

final class SchedulePresenter: SchedulePresenterProtocol {
    weak var view: ScheduleViewControllerProtocol?
    var delegate: CreateTrackerPresenterProtocol?
    
    var weekDays = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]
    
    var selectedIndexes = [Int]()
    
    
    func setupSchedule() {
        delegate?.updateCreateTrackerSchedule(with: selectedIndexes)
    }
    
}


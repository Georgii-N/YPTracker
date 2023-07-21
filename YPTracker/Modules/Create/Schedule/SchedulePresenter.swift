import Foundation

final class SchedulePresenter: SchedulePresenterProtocol {
    weak var view: ScheduleViewControllerProtocol?
    var delegate: CreateTrackerPresenterProtocol?
    
    var weekDays = [
        NSLocalizedString("monday", comment: ""),
        NSLocalizedString("tuesday", comment: ""),
        NSLocalizedString("wednesday", comment: ""),
        NSLocalizedString("thursday", comment: ""),
        NSLocalizedString("friday", comment: ""),
        NSLocalizedString("saturday", comment: ""),
        NSLocalizedString("sunday", comment: ""),
    ]
    
    var selectedIndexes = [Int]()
    
    
    func setupSchedule() {
        delegate?.updateCreateTrackerSchedule(with: selectedIndexes)
    }
    
}


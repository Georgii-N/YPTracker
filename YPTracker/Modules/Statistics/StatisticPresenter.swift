import Foundation

final class StatisticPresenter: StatisticPresenterProtocol {
    weak var view: StatisticViewControllerProtocol?
    
    private let coreDataManager = CoreDataManager.defaultManager
    
    init() {
        coreDataManager.trackerRecordStore?.statisticDelegate = self
    }
    
    func getCountOfCompletedTrackers() -> String {
        if let countOfCompletedTrackers = coreDataManager.trackerRecordStore?.getTrackersRecord().count {
            return String(countOfCompletedTrackers)
        } else {
            return "0"
        }
    }
}

extension StatisticPresenter: TrackerRecordStoreStatisticDelegate {
    func updateCount() {
        let stringCount = getCountOfCompletedTrackers()
        view?.setNewCount(count: stringCount)
    }
}

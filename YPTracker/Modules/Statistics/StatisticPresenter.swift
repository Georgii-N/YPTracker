import Foundation

final class StatisticPresenter: StatisticPresenterProtocol {
    weak var view: StatisticViewControllerProtocol?
    
    private let coreDataManager = CoreDataManager.defaultManager
    
    init() {
        coreDataManager.trackerRecordStore?.statisticDelegate = self
    }
    
    func getCountOfCompletedTrackers() -> Int {
        if let countOfCompletedTrackers = coreDataManager.trackerRecordStore?.getTrackersRecord().count {
            return countOfCompletedTrackers
        } else {
            return 0
        }
    }
}

extension StatisticPresenter: TrackerRecordStoreStatisticDelegate {
    func updateCount() {
        let count = getCountOfCompletedTrackers()
        print("PRINT count \(count)")
        
        count == 0 ? view?.showStub() : view?.hideStub()
            
        view?.setNewCount(count: String(count))
    }
}

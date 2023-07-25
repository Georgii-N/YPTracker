import Foundation

protocol StatisticPresenterProtocol {
    var view: StatisticViewControllerProtocol? { get set }
    
    func updateCount()
}

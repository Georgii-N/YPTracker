import Foundation

protocol StatisticViewControllerProtocol: AnyObject {
    var presenter: StatisticPresenterProtocol? { get set }
    
    func setNewCount(count: String)
}


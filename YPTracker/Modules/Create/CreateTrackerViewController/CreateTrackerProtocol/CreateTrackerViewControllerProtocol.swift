import Foundation

protocol CreateTrackerViewControllerProtocol: AnyObject {
    var presenter: CreateTrackerPresenterProtocol? { get set }
    var titlesFotTableView: [String] { get set}
    var selectedTitles: [String] { get set}
    var isEdit: Bool { get set }
    
    func unlockCreateButton()
    func lockCreateButton()
    func reloadTableView()
    func showTitleCountsOfDays()
    func changeTitleOfCreateButton()
    
}

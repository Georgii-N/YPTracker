import Foundation

protocol NewCategoryViewControllerProtocol: AnyObject {
    
    var presenter: NewCategoryPresenterProtocol? { get set }
    
    func makeButtonIsEnable()
    func makeButtonIsDisable()
    
    func showWarningMessage()
    func hideWarningMessage()
    
}

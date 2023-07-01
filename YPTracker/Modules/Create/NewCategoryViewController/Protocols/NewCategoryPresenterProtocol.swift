import Foundation

protocol NewCategoryPresenterProtocol {
    var view: NewCategoryViewControllerProtocol? { get set }
    var newCategory: String  { get set }
    
    func addNewCategory()
    func checkCategoryIsNew()
}

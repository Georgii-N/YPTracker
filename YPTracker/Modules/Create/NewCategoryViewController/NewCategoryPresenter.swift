import Foundation

final class NewCategoryPresenter: NewCategoryPresenterProtocol {
    weak var view: NewCategoryViewControllerProtocol?
    
    private let coreDataManager = CoreDataManager.defaultManager
    
    var newCategory: String = ""
    
    func addNewCategory() {
        coreDataManager.trackerCategoryStore?.addCategory(with: newCategory)
    }
    
    func checkCategoryIsNew() {
        guard let categories = coreDataManager.trackerCategoryStore?.getCategoriesNames() else { return }
        if categories.contains(newCategory) {
            view?.showWarningMessage()
            view?.makeButtonIsDisable()
        } else {
            view?.hideWarningMessage()
            view?.makeButtonIsEnable()
        }
    }
}

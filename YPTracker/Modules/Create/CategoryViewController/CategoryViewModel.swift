import Foundation

final class CategoryViewModel: TrackerCategoryStoreDelegate {
    
    private let coreDataManager = CoreDataManager.defaultManager
    
    var delegate: CreateTrackerPresenterProtocol?
    
    @CategoryObservable
    private(set) var visibleCategories: [String] = []
    
    init() {
        coreDataManager.trackerCategoryStore?.delegate = self
        fetchVisibleCategories()
    }
    
    func fetchVisibleCategories() {
        visibleCategories = coreDataManager.trackerCategoryStore?.getCategoriesNames() ?? []
    }
    
    func setSelectedCategory(with name: String) {
        delegate?.selectedCategory = name
    }
}

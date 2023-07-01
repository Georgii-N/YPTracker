import Foundation
protocol TrackerCategoryStoreProtocol {
    var delegate: TrackerCategoryStoreDelegate? { get set }
    
    func getCategory(byName name: String) -> TrackerCategoryCoreData
    func addCategory(with name: String)
    func getCategoriesNames() -> [String]
}

import Foundation
protocol TrackerCategoryStoreProtocol {
    func getCategory(byName name: String) -> TrackerCategoryCoreData
}

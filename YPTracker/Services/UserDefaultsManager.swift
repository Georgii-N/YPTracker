import Foundation

class UserDefaultsManager {
    static let isFirstLaunchKey = "isFirstLaunchKey"
    
    static var isFirstLaunch: Bool {
        get {
            return UserDefaults.standard.bool(forKey: isFirstLaunchKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: isFirstLaunchKey)
        }
    }
}

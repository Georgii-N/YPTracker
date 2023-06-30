import Foundation

class UserDefaultsManager {
    static let isFirstLaunchKey = "isFirstLaunchKey"
    
    static var isFirstLaunch: Bool {
        get {
            if UserDefaults.standard.object(forKey: isFirstLaunchKey) == nil {
                return true
            } else {
                return UserDefaults.standard.bool(forKey: isFirstLaunchKey)
            }
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: isFirstLaunchKey)
        }
    }
}

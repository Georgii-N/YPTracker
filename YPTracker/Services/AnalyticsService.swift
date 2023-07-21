import YandexMobileMetrica
import Foundation

enum Events: String {
    case click = "click"
    case open = "open"
    case close = "close"
}

enum Screen: String {
    case main = "Main"
}

enum Items: String {
    case addTrack = "add_track"
    case track = "track"
    case filter = "filter"
    case edit = "edit"
    case delete = "delete"
    case pin = "pin"
    case unpin = "unpin"
}

final class AnalyticsService {
    
    static let instance = AnalyticsService()

    private init() {}
    
    func sentEvent(typeOfEvent: Events, screen: Screen, item: Items?) {
        var parameters: [AnyHashable: Any] = [:]
        
        if item == nil {
            parameters = ["event": typeOfEvent.rawValue, "screen": screen.rawValue]
        } else {
            guard let item = item else { return }
            parameters = ["event": typeOfEvent.rawValue, "screen": screen.rawValue, "item": item.rawValue]
        }
        YMMYandexMetrica.reportEvent("EVENT", parameters: parameters) { error in
            print("DID FAIL REPORT EVENT: %@")
            print("REPORT ERROR: %@", error.localizedDescription)
        }
    }
}

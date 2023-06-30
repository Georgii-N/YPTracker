import Foundation

extension TrackerRecord: Equatable {
    
    static func == (lhs: TrackerRecord, rhs: TrackerRecord) -> Bool {
        return lhs.id == rhs.id && lhs.date == rhs.date
    }
}

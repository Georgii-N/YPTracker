import UIKit

struct Tracker {
    let id: UUID
    let color: UIColor
    let emoji: String
    let name: String
    let category: TrackerCategory
    let schedule: [Int]?
}


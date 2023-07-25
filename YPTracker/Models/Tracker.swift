import UIKit

struct Tracker {
    let id: UUID
    let color: UIColor
    let emoji: String
    let name: String
    var isPinned: Bool
    let schedule: [Int]?
}


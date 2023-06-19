import UIKit

final class StorageSingleton {
    static var storage = StorageSingleton()
    
    private init() {}
    
    var selectedCategory: String?
    var trackerName: String?
    var trackerColor: UIColor?
    var trackerEmoji: String?
    var trackerSchedule: [Int]?
    
    var completedTrackers: [TrackerRecord]?
    
    var weekDays = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]
    
    var categories: [TrackerCategory] = [
        TrackerCategory(name: "Дефолтная категория",
                        listOfTrackers: [Tracker(id: UUID(),
                                                 color: R.Colors.ColorsForCollection.colorCollection12,
                                                 emoji: "😇",
                                                 name: "Дефолт",
                                                 schedule: [0,3,5])
                        ]),
        TrackerCategory(name: "Важное",
                        listOfTrackers: [Tracker(id: UUID(),
                                                 color: R.Colors.ColorsForCollection.colorCollection12,
                                                 emoji: "😇",
                                                 name: "еще одна",
                                                 schedule: [0,3,5]),
                                         Tracker(id: UUID(),
                                                                  color: R.Colors.ColorsForCollection.colorCollection12,
                                                                  emoji: "😇",
                                                                  name: "ежедневное",
                                                                  schedule: [0,2,3,4,5,6])
                        ])
    ]
    
    func trackerScheduleToString(indexes: [Int]) -> String {
        var shortenedNames = [String]()
        for index in indexes {
            switch index {
            case 0:
                shortenedNames.append("Пн")
            case 1:
                shortenedNames.append("Вт")
            case 2:
                shortenedNames.append("Ср")
            case 3:
                shortenedNames.append("Чт")
            case 4:
                shortenedNames.append("Пт")
            case 5:
                shortenedNames.append("Сб")
            case 6:
                shortenedNames.append("Вс")
            default:
                shortenedNames.append("Пн")
            }
        }
        
        return shortenedNames.joined(separator: ", ")
    }
}

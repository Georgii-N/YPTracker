import UIKit

final class StorageSingleton {
    static var storage = StorageSingleton()
    
    private init() {}
    
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
    
    
}

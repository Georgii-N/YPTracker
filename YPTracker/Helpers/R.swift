import UIKit

enum R {
    enum Colors {
        static let trBlue = UIColor(hexString: "#3772E7")
        static let trGray = UIColor(hexString: "#AEAFB4")
        static let trBlack = UIColor(hexString: "#1A1B22")
    }
    
    enum Images {
        enum TabBar {
            static let trackersIcon = UIImage(named: "tabBarTrackersIcon")
            static let statisticIcon = UIImage(named: "tabBarStatisticIcon")
        }
        
        enum Common {
            static let stubImage = UIImage(named: "stub")
        }
        
        enum NavBar {
            static let plusIcon = UIImage(named: "plus")
        }
    }
}


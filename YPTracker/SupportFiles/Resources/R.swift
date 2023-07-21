import UIKit

enum R {
    enum Colors {
        static let trBlue = UIColor(hexString: "#3772E7")
        static let trGray = UIColor(hexString: "#AEAFB4")
        static let trBlack = UIColor(hexString: "#1A1B22")
        static let trRed = UIColor(hexString: "#F56B6C")
        static let trBackgroundDay = UIColor(hexString: "#E6E8EB")
        static let trBackgroundWhite = UIColor(hexString: "#F0F0F0")
        
        enum ColorsForCollection {
            static let colorCollection1 = UIColor(hexString: "#FD4C49")
            static let colorCollection2 = UIColor(hexString: "#FF881E")
            static let colorCollection3 = UIColor(hexString: "#007BFA")
            static let colorCollection4 = UIColor(hexString: "#6E44FE")
            static let colorCollection5 = UIColor(hexString: "#33CF69")
            static let colorCollection6 = UIColor(hexString: "#E66DD4")
            static let colorCollection7 = UIColor(hexString: "#F9D4D4")
            static let colorCollection8 = UIColor(hexString: "#34A7FE")
            static let colorCollection9 = UIColor(hexString: "#46E69D")
            static let colorCollection10 = UIColor(hexString: "#35347C")
            static let colorCollection11 = UIColor(hexString: "#FF674D")
            static let colorCollection12 = UIColor(hexString: "#FF99CC")
            static let colorCollection13 = UIColor(hexString: "#F6C48B")
            static let colorCollection14 = UIColor(hexString: "#7994F5")
            static let colorCollection15 = UIColor(hexString: "#832CF1")
            static let colorCollection16 = UIColor(hexString: "#AD56DA")
            static let colorCollection17 = UIColor(hexString: "#8D72E6")
            static let colorCollection18 = UIColor(hexString: "#2FD058")
        }
    }
    
    enum Images {
        enum TabBar {
            static let trackersIcon = UIImage(named: "tabBarTrackersIcon")
            static let statisticIcon = UIImage(named: "tabBarStatisticIcon")
        }
        
        enum Common {
            static let stubImage = UIImage(named: "stub")
            static let stubAfterSearch = UIImage(named: "stubAfterSearch")
            static let pinned = UIImage(named: "pinned")
        }
        
        enum NavBar {
            static let plusIcon = UIImage(named: "plus")
        }
        
        enum Onboarding {
            static let firstPageBackground = UIImage(named: "onboardingFirst")
            static let secondPageBackground = UIImage(named: "onboardingSecond")
        }
    }
}


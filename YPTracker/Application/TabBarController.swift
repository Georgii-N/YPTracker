import UIKit

final class TabBarController: UITabBarController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupUI()
        applyCurrentTheme()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true
        
        let trackersViewController = TrackersViewController()
        let trackersPresenter = TrackersPresenter()
        trackersViewController.presenter = trackersPresenter
        trackersPresenter.view = trackersViewController
        
        let statisticViewController = StatisticViewController()
        let statisticPresenter = StatisticPresenter()
        statisticViewController.presenter = statisticPresenter
        statisticPresenter.view = statisticViewController
        
        let trackersNavigationViewController = UINavigationController(rootViewController: trackersViewController)
        trackersNavigationViewController.tabBarItem = UITabBarItem(title: NSLocalizedString("trackersView.title", comment: ""), image: R.Images.TabBar.trackersIcon, selectedImage: nil)
        
        
        
        let statisticNavigationViewController = UINavigationController(rootViewController: statisticViewController)
        statisticNavigationViewController.tabBarItem = UITabBarItem(title: NSLocalizedString("statisticView.title", comment: ""), image: R.Images.TabBar.statisticIcon, selectedImage: nil)
        
        setViewControllers([trackersNavigationViewController, statisticNavigationViewController], animated: false)
    }
    
    private func applyCurrentTheme() {
        if traitCollection.userInterfaceStyle == .dark {
                         tabBar.backgroundColor = R.Colors.trBlack
                         tabBar.barTintColor = R.Colors.trGray
                         tabBar.tintColor = R.Colors.trBlue
                         tabBar.layer.borderColor = R.Colors.trBlack.cgColor
                         
                     } else if traitCollection.userInterfaceStyle == .light {
                         tabBar.tintColor = R.Colors.trBlue
                         tabBar.barTintColor = R.Colors.trGray
                         tabBar.backgroundColor = .white
                         tabBar.layer.borderColor = R.Colors.trGray.cgColor
                     }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if #available(iOS 13.0, *),
             traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
             applyCurrentTheme()
         }
    }
}

import UIKit

final class TabBarController: UITabBarController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        tabBar.tintColor = R.Colors.trBlue
        tabBar.barTintColor = R.Colors.trGray
        tabBar.backgroundColor = .white
        
        tabBar.layer.borderColor = R.Colors.trGray.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true
        
        let trackersViewController = TrackersViewController()
        let trackersPresenter = TrackersPresenter()
        trackersViewController.presenter = trackersPresenter
        trackersPresenter.view = trackersViewController
        
        let statisticViewController = StatisticViewController()
        
        let trackersNavigationViewController = UINavigationController(rootViewController: trackersViewController)
        trackersNavigationViewController.tabBarItem = UITabBarItem(title: NSLocalizedString("trackersView.title", comment: ""), image: R.Images.TabBar.trackersIcon, selectedImage: nil)
        
        
        
        let statisticNavigationViewController = UINavigationController(rootViewController: statisticViewController)
        statisticNavigationViewController.tabBarItem = UITabBarItem(title: NSLocalizedString("statisticView.title", comment: ""), image: R.Images.TabBar.statisticIcon, selectedImage: nil)
        
        setViewControllers([trackersNavigationViewController, statisticNavigationViewController], animated: false)
    }
}

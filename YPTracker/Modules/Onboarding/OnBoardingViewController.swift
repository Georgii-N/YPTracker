import UIKit

final class OnboardingViewController: UIPageViewController {
    
    private lazy var pages: [BaseOnboardingViewController] = {
        let firstVC = BaseOnboardingViewController(
            customTitle: R.Strings.Onboarding.firstPageTitle,
            titleButton: R.Strings.Buttons.buttonOnboarding,
            image: R.Images.Onboarding.firstPageBackground ?? UIImage())
        
        let secondVC = BaseOnboardingViewController(
            customTitle: R.Strings.Onboarding.secondPageTitle,
            titleButton: R.Strings.Buttons.buttonOnboarding,
            image: R.Images.Onboarding.secondPageBackground ?? UIImage())
        
        return [firstVC, secondVC]
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        
        pageControl.currentPageIndicatorTintColor = R.Colors.trBlack.withAlphaComponent(0.3)
        pageControl.pageIndicatorTintColor =  R.Colors.trBlack
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        if let first = pages.first {
            setViewControllers([first], direction: .forward, animated: true, completion: nil)
        }
        
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 638),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}


extension OnboardingViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController as! BaseOnboardingViewController) else {
                    return nil
                }
                
                let previousIndex = viewControllerIndex - 1
                
                guard previousIndex >= 0 else {
                    return nil
                }
                
                return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController as! BaseOnboardingViewController) else {
                    return nil
                }
                
                let nextIndex = viewControllerIndex + 1
                
                guard nextIndex < pages.count else {
                    return nil
                }
                
                return pages[nextIndex]
    }

}

extension OnboardingViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            
            if let currentViewController = pageViewController.viewControllers?.first,
               let currentIndex = pages.firstIndex(of: currentViewController as! BaseOnboardingViewController) {
                pageControl.currentPage = currentIndex
            }
        }
}

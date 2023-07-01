import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        if UserDefaultsManager.isFirstLaunch  {
                    showOnboarding()
                    UserDefaultsManager.isFirstLaunch = false
                } else {
                    showMainScreen()
                }
    }
    
    private func showOnboarding() {
            let onboardingViewController = OnboardingViewController()
            
            window?.rootViewController = onboardingViewController
            window?.makeKeyAndVisible()
        }
        
        private func showMainScreen() {
            let tabBarController = TabBarController()
            
            window?.rootViewController = tabBarController
            window?.makeKeyAndVisible()
        }
}


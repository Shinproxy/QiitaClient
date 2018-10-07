import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        let articleListViewController = ArticleListViewController()
        window?.rootViewController = articleListViewController
        window?.makeKeyAndVisible()
        
        return true
    }

}


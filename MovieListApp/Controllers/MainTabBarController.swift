import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: BookmarksViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "house.fill")
        vc2.tabBarItem.image = UIImage(systemName: "bookmark.circle.fill")
        
        vc1.title = "Home"
        vc2.title = "Bookmarks"
        
        tabBar.tintColor = .label
        tabBar.backgroundColor = .systemBackground
        setViewControllers([vc1,vc2], animated: true)
    }
}

import UIKit

final class MainTabBarController: UITabBarController {

    private let vc1: UINavigationController = UINavigationController(rootViewController: HomeViewController())
    private let vc2: UINavigationController = UINavigationController(rootViewController: BookmarksViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
      
    }
    
    private func configure() {
        vc1.tabBarItem.image = UIImage(systemName: "house.fill")
        vc2.tabBarItem.image = UIImage(systemName: "bookmark.circle.fill")
        
        vc1.title = "Home"
        vc2.title = "Bookmarks"
        
        tabBar.tintColor = .label
        tabBar.backgroundColor = .systemBackground
        setViewControllers([vc1,vc2], animated: true)
    }
}

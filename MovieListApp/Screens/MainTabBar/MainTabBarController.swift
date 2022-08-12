import UIKit

final class MainTabBarController: UITabBarController {

    private let homeViewController: UINavigationController = UINavigationController(rootViewController: HomeViewController())
    private let bookmarksViewController: UINavigationController = UINavigationController(rootViewController: BookmarksViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        homeViewController.tabBarItem.image = UIImage(systemName: "house.fill")
        bookmarksViewController.tabBarItem.image = UIImage(systemName: "bookmark.circle.fill")
        
        homeViewController.title = "Home"
        bookmarksViewController.title = "Bookmarks"
        
        tabBar.tintColor = .label
        tabBar.backgroundColor = .systemBackground
        setViewControllers([homeViewController,bookmarksViewController], animated: true)
    }
}

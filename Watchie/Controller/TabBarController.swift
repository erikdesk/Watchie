import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        overrideUserInterfaceStyle = .dark
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // this runs when tab is clicked, not just on once app load.
        
        tabBar.tintColor = .white
        tabBar.barTintColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 0.9) // adjust alpha.
        tabBar.isTranslucent = true
        tabBar.unselectedItemTintColor = .darkGray
        
//        let homeRootVC = HomeCollectionController(collectionViewLayout: UICollectionViewFlowLayout())
//        let homeNavVC = HomeNavController(rootViewController: homeRootVC)
//        homeNavVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "arrow.up.right.video.fill"), selectedImage: nil)
//        homeNavVC.tabBarItem.setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 14)], for: .normal)
////        homeNavVC.title = "Home" // not working..
        
        let todoRootVC = TodoCollectionController(collectionViewLayout: UICollectionViewFlowLayout())
        let todoNavVC = TodoNavController(rootViewController: todoRootVC)
        todoNavVC.tabBarItem = UITabBarItem(title: "To-do", image: UIImage(systemName: "newspaper.fill"), selectedImage: nil)
        todoNavVC.tabBarItem.setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 14)], for: .normal)
//        todoNavVC.title = "To-do" // not working..
        
        let watchedRootVC = WatchedCollectionController(collectionViewLayout: UICollectionViewFlowLayout())
        let watchedNavVC = WatchedNavController(rootViewController: watchedRootVC)
        watchedNavVC.tabBarItem = UITabBarItem(title: "Watched", image: UIImage(systemName: "play.tv.fill"), selectedImage: nil)
        watchedNavVC.tabBarItem.setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 14)], for: .normal)
//        watchedNavVC.title = "Watched" // not working..
        
        let trashedRootVC = TrashedCollectionController(collectionViewLayout: UICollectionViewFlowLayout())
        let trashedNavVC = TrashedNavController(rootViewController: trashedRootVC)
        trashedNavVC.tabBarItem = UITabBarItem(title: "Trash Bin", image: UIImage(systemName: "trash.fill"), selectedImage: nil)
        trashedNavVC.tabBarItem.setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 14)], for: .normal)
//        trashedNavVC.title = "Trash" // not working..
        
        let searchRootVC = SearchCollectionController(collectionViewLayout: UICollectionViewFlowLayout())
        let searchNavVC = SearchNavController(rootViewController: searchRootVC)
        searchNavVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: nil)
        searchNavVC.tabBarItem.setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 14)], for: .normal)
//        searchNavVC.title = "Search" // not working..
        
        
        
        // homeNavVC
        let controllers = [todoNavVC, watchedNavVC, trashedNavVC, searchNavVC]
        self.viewControllers = controllers
        
        selectedIndex = 0
    }
    
    
}

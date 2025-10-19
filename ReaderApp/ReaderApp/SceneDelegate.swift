
//  SceneDelegate.swift
//  ReaderApp
//
//  Created by Prraneth on 19/10/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let articlesVC = UINavigationController(rootViewController: ArticlesViewController())
        articlesVC.tabBarItem = UITabBarItem(title: "News", image: UIImage(systemName: "newspaper"), tag: 0)
        
        let bookmarksVC = UINavigationController(rootViewController: BookmarksViewController())
        bookmarksVC.tabBarItem = UITabBarItem(title: "Bookmarks", image: UIImage(systemName: "bookmark"), tag: 1)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [articlesVC, bookmarksVC]
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}

//
//  AppTabBarController.swift
//  EventifyApp
//
//  Created by Рассказов Глеб on 18.03.2024.
//

import UIKit

class AppTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupItems()
        setupAppearance()
    }
    
    private func setupItems() {
        viewControllers = AppTabBarItem.allCases.map { setupNavigationController(item: $0) }
    }
    
    private func setupNavigationController(item: AppTabBarItem) -> UINavigationController {
        let navigationViewController = UINavigationController(rootViewController: item.viewController)
        
        navigationViewController.tabBarItem.image = item.icon?.resized(to: CGSize(width: 20, height: 18))
        navigationViewController.tabBarItem.title = item.title
        
        item.viewController.navigationItem.title = item.title
        
        return navigationViewController
    }
    
    private func setupAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(hex: "#242427")
        tabBar.tintColor = UIColor(hex: "DDF14A")
        tabBar.scrollEdgeAppearance = appearance
        
        tabBar.layer.cornerRadius = 10
        tabBar.layer.masksToBounds = true
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}

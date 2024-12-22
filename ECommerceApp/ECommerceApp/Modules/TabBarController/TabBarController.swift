//
//  TabBarController.swift
//  ECommerceApp
//
//  Created by Rami Mustafa on 20.12.24.
//

import UIKit

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ViewController'ları oluştur
        let firstVC  = ProductsViewController()
        let secondVC = CartViewController()
        let thirdVC  = ViewController()
        let fourthVC = ViewController()
        
        // Tab Bar Item'ları ayarla
        firstVC.tabBarItem = UITabBarItem(title:  nil, image: UIImage(named: "iconHome")?.withRenderingMode(.alwaysOriginal), tag: 0)
        secondVC.tabBarItem = UITabBarItem(title: nil , image: UIImage(named: "iconBasket"), tag: 1)
        thirdVC.tabBarItem = UITabBarItem(title:  nil, image: UIImage(named: "iconStar"), tag: 2)
        fourthVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "iconPerson"), tag: 3)
        
        
        let inset = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        [firstVC, secondVC, thirdVC, fourthVC].forEach { $0.tabBarItem.imageInsets = inset }

        viewControllers = [ firstVC, secondVC, thirdVC, fourthVC ]
        
        tabBar.tintColor = .black
         tabBar.unselectedItemTintColor = .black
         tabBar.barTintColor = .white

        addTopBorderToTabBar()
    }
    private func addTopBorderToTabBar() {

        let topBorder = CALayer()
          topBorder.frame = CGRect(x: 0, y: 0, width: tabBar.frame.width, height: 1)
          topBorder.backgroundColor = UIColor.lightGray.cgColor
          
          // TabBar'ın üstüne ekle
          tabBar.layer.addSublayer(topBorder)
        
      }
}

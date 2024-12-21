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
        let secondVC = ViewController()
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
        
        // Tab Bar renkleri
         tabBar.tintColor = .black // Seçili durum rengi
         tabBar.unselectedItemTintColor = .black // Seçili olmayan ikon rengi
         tabBar.barTintColor = .white // Arka plan rengi

        addTopBorderToTabBar()
    }
    private func addTopBorderToTabBar() {
          // Çizgi için bir CALayer oluştur
          let topBorder = CALayer()
          topBorder.frame = CGRect(x: 0, y: 0, width: tabBar.frame.width, height: 1) // Yükseklik 1px
          topBorder.backgroundColor = UIColor.lightGray.cgColor // Çizgi rengi
          
          // TabBar'ın üstüne ekle
          tabBar.layer.addSublayer(topBorder)
          
          // Gölge eklemek için tabBar.layer ayarları
          tabBar.layer.shadowOffset = CGSize(width: 0, height: -6) // Gölgenin konumu
          tabBar.layer.shadowRadius = 6 // Gölgenin yumuşaklığı
          tabBar.layer.shadowColor = UIColor.black.cgColor // Gölge rengi
          tabBar.layer.shadowOpacity = 0.3 // Gölge opaklığı
          tabBar.layer.masksToBounds = false // Gölgenin görünmesi için maskeyi kaldır
        
        
//        tabBar.layer.shadowOffset = CGSize(width: 0, height: -3)
//        tabBar.layer.shadowRadius = 4
//        tabBar.layer.shadowColor = UIColor.black.cgColor
//        tabBar.layer.shadowOpacity = 0.3
//        tabBar.layer.masksToBounds = false
//        
//        // TabBar'ın üstüne ince bir çizgi ekleme
//        let topBorder = CALayer()
//        topBorder.frame = CGRect(x: 0, y: 0, width: tabBar.frame.width, height: 1)
//        topBorder.backgroundColor = UIColor.lightGray.cgColor
//        tabBar.layer.addSublayer(topBorder)
        
      }
}

//
//let tabBarHeight = tabBarController?.tabBar.frame.height ?? 0
//label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -tabBarHeight),

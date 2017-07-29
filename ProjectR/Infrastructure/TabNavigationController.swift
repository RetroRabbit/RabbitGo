//
//  TabNavigationController.swift
//  ProjectR
//
//  Created by Wesley Buck on 2017/07/17.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import UIKit
import Material

class TabNavigationController: Material.BottomNavigationController {
    override init() {
        super.init(viewControllers: [
            ToolNavigationController(rootViewController: RabbiteerHomeController.instance),
            ToolNavigationController(rootViewController: QuestionsController.instance),
            ToolNavigationController(rootViewController: ScanQRController.instance),
            ToolNavigationController(rootViewController: ProfileController.instance)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func prepare() {
        super.prepare()
        prepareTabBar()
        delegate = self
    }
    
    fileprivate func prepareTabBar() {
        tabBar.backgroundColor = Material.Color.black
        
        tabBar.tintColor = Style.color.green
        tabBar.unselectedItemTintColor = Style.color.white
        
        let tabBarItemApperance = UITabBarItem.appearance()
        tabBarItemApperance.setTitleTextAttributes([NSForegroundColorAttributeName:Style.color.white], for: .normal)
        tabBarItemApperance.setTitleTextAttributes([NSForegroundColorAttributeName:Style.color.green], for: .selected)
    }
}

enum NavigationTab: Int {
    case questions = 0
    case scanQR = 1
    case home = 2
    case prizes = 3
    case myprofile = 4
}


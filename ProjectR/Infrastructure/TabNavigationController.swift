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
//            ToolNavigationController(rootViewController: QuestionsController.instance),
            ToolNavigationController(rootViewController: ScanQRController.instance),
            ToolNavigationController(rootViewController: HomeController.instance),
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
        tabBar.backgroundColor = Color.black
        
        tabBar.selectionIndicatorImage =
            imageWithColor(
                Style.color.grey_dark,
                size: CGSize(
                    width: tabBar.frame.width / 4.0,
                    height: tabBar.frame.height))
        
        let tabBarItemApperance = UITabBarItem.appearance()
        tabBarItemApperance.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.white], for: .normal)
        tabBarItemApperance.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.white], for: .selected)
    }
    
    func imageWithColor(_ color: UIColor, size: CGSize) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

enum NavigationTab: Int {
    case questions = 0
    case scanQR = 1
    case home = 2
    case prizes = 3
    case myprofile = 4
}


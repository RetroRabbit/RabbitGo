//
//  ToolNavigationController.swift
//  ProjectR
//
//  Created by Wesley Buck on 2017/07/17.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import UIKit
import Material

class ToolNavigationController: Material.NavigationController, ToolNavigationDelegate {
    static let barColor = Color.blueGrey.darken4
    var shouldShowBackButton: Bool = true
    
    open override func prepare() {
        super.prepare()
        if let navBar = navigationBar as? NavigationBar {
            navBar.backgroundColor = ToolNavigationController.barColor
            navBar.tintColor = Color.white
            if shouldShowBackButton {
                navBar.backButtonImage = Material.Icon.arrowBack
            }
            navBar.backButtonImage?.accessibilityIdentifier = "ToolNavigationController.backButtonImage.Left"
        }
        
        navigationItem.titleLabel.textAlignment = .left
        navigationItem.titleLabel.textColor = Material.Color.blueGrey.lighten3
        navigationItem.detailLabel.textAlignment = .left
        navigationItem.detailLabel.textColor = Material.Color.blueGrey.lighten2
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        setNavigationBarHidden(false, animated: animated)
        super.pushViewController(viewController, animated: animated)
    }
}

protocol ToolNavigationDelegate {
    var navigationController: UINavigationController? { get }
}

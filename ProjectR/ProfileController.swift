//
//  ProfileController.swift
//  ProjectR
//
//  Created by Wesley Buck on 2017/07/17.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import Foundation
import UIKit
import Material

class ProfileController: UIViewController {
    static let instance = ProfileController()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        //super.init()
        //super.init(hiding: NavigationHide.toBottom)
        navigationController?.title = "Leaderboard Position #43"
        tabBarItem.title = "My Profile"
        tabBarItem.image = Material.Icon.pen
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

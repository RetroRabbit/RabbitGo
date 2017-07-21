//
//  PrizesController.swift
//  ProjectR
//
//  Created by Wesley Buck on 2017/07/17.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import Foundation
import UIKit
import Material

class PrizesController: UIViewController {
    static let instance = PrizesController()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        //super.init()
        //super.init(hiding: NavigationHide.toBottom)
        navigationController?.title = "Leaderboard Position #43"
        tabBarItem.title = "Prizes"
        tabBarItem.image = Material.Icon.star
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

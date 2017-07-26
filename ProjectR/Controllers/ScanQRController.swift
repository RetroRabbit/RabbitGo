//
//  ScanQR.swift
//  ProjectR
//
//  Created by Wesley Buck on 2017/07/17.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import Foundation
import UIKit
import Material

class ScanQRController: UIViewController {
    static let instance = ScanQRController()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        //super.init()
        //super.init(hiding: NavigationHide.toBottom)
        navigationController?.title = "Leaderboard Position #43"
        tabBarItem.title = "ScanQR"
        tabBarItem.image = Material.Icon.photoCamera
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

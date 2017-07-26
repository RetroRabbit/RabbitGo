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

class ScanQRController: UIViewNavigationController {
    static let instance = ScanQRController()
    
    init() {
        super.init()
        tabBarItem.title = "Scan QR"
        tabBarItem.image = Material.Icon.photoCamera
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareToolbar() {
        setTitle("SCAN QR CODE", subtitle: nil)
    }
}

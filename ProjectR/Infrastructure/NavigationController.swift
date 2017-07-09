//
//  NavigationController.swift
//  ProjectR
//
//  Created by Henko on 2017/07/09.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import Foundation
import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Status bar white font
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.retroBlack]
        self.navigationBar.barStyle = UIBarStyle.default
        self.navigationBar.tintColor = UIColor.retroGreen
    }
}

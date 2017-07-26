//
//  BaseNextController.swift
//  ProjectR
//
//  Created by Wesley Buck on 2017/07/21.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import UIKit
import Material

class BaseNextController: UIViewController {
    internal let nextButton:ProjectRNext = ProjectRNext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        view.backgroundColor = Style.color.grey_dark
        
        view.addSubview(nextButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        nextButton.frame = CGRect(x: (Screen.width - Style.button_width)/2, y: (Screen.height - Style.button_height) - 30, width: Style.button_width, height: Style.button_height)
    }
}

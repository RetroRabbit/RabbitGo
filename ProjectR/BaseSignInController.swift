//
//  BaseSignInController.swift
//  ProjectR
//
//  Created by Wesley Buck on 2017/07/21.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import Material
import UIKit

class BaseSignInController: UIViewController {
    internal let logo: UIImageView = {
        let imgViewSplash = UIImageView(image: UIImage(named: "splash-screen"))
        imgViewSplash.contentMode = .scaleAspectFill
        return imgViewSplash
    }()
    
    internal let headingLabel: UILabel = UILabel()
    
    internal let nextButton:ProjectRNext = ProjectRNext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        view.backgroundColor = Style.color.grey_dark
        view.addSubview(logo)
        view.addSubview(headingLabel)
        
        view.addSubview(nextButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logo.frame = CGRect(x: (Screen.width - 112)/2, y: Style.padding.s, width: 112, height: 152)
        headingLabel.frame = CGRect(x: 40, y: logo.frame.bottom + 30, width: Screen.width - 80, height: headingLabel.intrinsicContentSize.height)
        
        nextButton.frame = CGRect(x: (Screen.width - Style.button_width)/2, y: (Screen.height - Style.button_height) - 30, width: Style.button_width, height: Style.button_height)
    }
}

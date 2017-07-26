//
//  UIViewController + ProjectR.swift
//  ProjectR
//
//  Created by Wesley Buck on 2017/07/26.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import UIKit

extension UIViewController {
    func setTitle(_ title:String, subtitle:String?) {
        navigationItem.title = title
        navigationItem.titleLabel.textColor = Style.color.white
        
        navigationItem.detail = subtitle
        navigationItem.detailLabel.textColor = Style.color.white
    }
}

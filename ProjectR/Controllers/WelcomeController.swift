//
//  WelcomeController.swift
//  ProjectR
//
//  Created by Hugo Meiring on 2017/07/21.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import Foundation
import UIKit
import PureLayout
import Material

class WelcomeController: BaseSignInController {
    /* UI */
    fileprivate let lblMainHead: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Welcome\nto Rabbittania", attributes: Style.avenirh_extra_large_white)
        label.textColor = Material.Color.white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    fileprivate let lblBody: UILabel = {
        let label = UILabel()
        let str = "For your quest today, scan as many QR codes as you can find! Each QR code unlocks a new rabbit, but don’t be fooled, as this is not the rabbit’s final form! Answer their questions too & discover all the great secrets of Rabbitania! You may ask any Rabbit for the answers to the questions, but you’ll have to enter their unique Rabbit- codes to submit & verify your answers!"
        label.attributedText = NSAttributedString(string: str, attributes: Style.avenirl_small_white)
        label.textColor = Material.Color.white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    fileprivate let lblStatesHead: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "RABBIT QUESTION STATES:", attributes: Style.avenirh_medium_white)
        label.textColor = Material.Color.white
        return label
    }()
    
    fileprivate let lblLocked: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Locked", attributes: Style.avenirl_extra_small_white)
        label.textColor = Material.Color.white
        return label
    }()
    
    fileprivate let lblUnlocked: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Unlocked", attributes: Style.avenirl_extra_small_white)
        label.textColor = Material.Color.white
        return label
    }()
    
    fileprivate let lblAnswered: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Answered", attributes: Style.avenirl_extra_small_white)
        label.textColor = Material.Color.white
        return label
    }()
    
    fileprivate let lblSubImageText: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "The one who answers all the\nquestions first, WINS!", attributes: Style.avenirl_small_white_center)
        label.textColor = Material.Color.white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    fileprivate let lblGoodLuck: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "GOOD LUCK!", attributes: Style.rhino_large_white)
        label.textColor = Material.Color.lime.base
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(lblMainHead)
        view.addSubview(lblBody)
        view.addSubview(lblStatesHead)
        view.addSubview(lblLocked)
        view.addSubview(lblUnlocked)
        view.addSubview(lblAnswered)
        view.addSubview(lblSubImageText)
        view.addSubview(lblGoodLuck)
        
        nextButton.addTarget(self, action: #selector(temp), for: UIControlEvents.touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        lblMainHead.frame = CGRect(x: Style.padding.xxl, y: Style.padding.xxl, width: Screen.width, height: lblMainHead.intrinsicContentSize.height)
        lblBody.frame = CGRect(x: Style.padding.xxl, y: lblMainHead.height + lblMainHead.y + Style.padding.xxl, width: Screen.width, height: lblBody.intrinsicContentSize.height)
        lblStatesHead.frame = CGRect(x: Style.padding.xxl, y: lblBody.y + Style.padding.xxl * 2, width: Screen.width, height: lblStatesHead.intrinsicContentSize.height)
        lblSubImageText.frame = CGRect(x: Style.padding.xxl, y: lblStatesHead.y + Style.padding.xxl, width: Screen.width, height: lblSubImageText.intrinsicContentSize.height)
        lblGoodLuck.frame = CGRect(x: Style.padding.xxl, y: lblSubImageText.y + Style.padding.xxl, width: Screen.width, height: lblGoodLuck.intrinsicContentSize.height)
        logo.frame = CGRect()
    }
    
    func temp() {
        navigationController?.pushViewController(SignInController(), animated: true)
    }
}






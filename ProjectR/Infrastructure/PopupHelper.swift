//
//  popupHelper.swift
//  ProjectR
//
//  Created by Niell Agenbag on 2017/07/13.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import Foundation
import UIKit
import Material

class popupHelper: UIViewController{
    lazy var textLabel:UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.attributedText = NSAttributedString(string: "", attributes: Style.body)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        return lbl
    }()
    
    lazy var doneButton:Button = {
        let btn = Button()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("NEXT", for: .normal)
        btn.backgroundColor = UIColor.retroBlack
        btn.layer.cornerRadius = 2
        btn.layer.borderWidth = 2
        btn.titleLabel?.textColor = UIColor.retroGreen
        btn.tintColor = UIColor.retroGreen
        btn.addTarget(self, action: #selector(onDone), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    let viewBackground:UIVisualEffectView = {
        let blur = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    }()
    
    let popupContainer:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        
        view.addSubview(viewBackground)
        viewBackground.frame = view.frame
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func basePopUp(title: String, text:String, btnTitle:String){
        
        view.addSubview(popupContainer)
        view.addSubview(textLabel)
        view.addSubview(doneButton)

        textLabel.attributedText = NSAttributedString(string: text, attributes: Style.body)
        
        doneButton.setTitle(btnTitle, for: .normal)
        
        textLabel.preferredMaxLayoutWidth = Screen.width - 80
        textLabel.frame = CGRect(x: (Screen.width - textLabel.intrinsicContentSize.width)/2, y: 140, width: Screen.width - 80, height: textLabel.intrinsicContentSize.height)
        
        doneButton.frame = CGRect(x: 40, y: textLabel.frame.bottom + 30, width: Screen.width - 80, height: 40)
        
        popupContainer.frame = CGRect(x: 30, y: 130, width: Screen.width - 60, height: textLabel.intrinsicContentSize.height + doneButton.frame.height + 50)
        
    }
}

extension popupHelper {
    
    func onDone() {
        self.dismiss(animated: true, completion: {action -> Void in})
    }
}

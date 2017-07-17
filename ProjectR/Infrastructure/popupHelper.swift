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
    
    let titleLabel:UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.attributedText = NSAttributedString(string: "", attributes: Style.body)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        return lbl
    }()
    
    lazy var bodyLabel:UILabel = {
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
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    func basePopUp(title:String, text:String, btnTitle:String){
        
        popupContainer.addSubview(titleLabel)
        popupContainer.addSubview(bodyLabel)
        popupContainer.addSubview(doneButton)

        bodyLabel.attributedText = NSAttributedString(string: text, attributes: Style.body)
        doneButton.setTitle(btnTitle, for: .normal)
        
        bodyLabel.frame = CGRect(x: 10, y: (Screen.height - bodyLabel.intrinsicContentSize.height)/2, width: Screen.width - 80, height: bodyLabel.intrinsicContentSize.height)
        
        doneButton.frame = CGRect(x: 10, y: bodyLabel.frame.bottom + 60, width: Screen.width - 80, height: 40)
        
        if !title.isEmpty{
            
            titleLabel.attributedText = NSAttributedString(string: title, attributes: Style.body)
            titleLabel.frame = CGRect(x: (Screen.width - titleLabel.intrinsicContentSize.width)/2, y: bodyLabel.frame.top - 10, width: titleLabel.intrinsicContentSize.width, height: titleLabel.intrinsicContentSize.height)
        }
        
        view.addSubview(popupContainer)
        
        popupContainer.frame = CGRect(x: 30, y: titleLabel.frame.top - 10, width: Screen.width - 60, height: doneButton.frame.bottom + 10)
    }

}

extension popupHelper {
    
    func onDone() {
        self.dismiss(animated: true, completion: {action -> Void in})
    }
}

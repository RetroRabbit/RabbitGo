//
//  SignInXController.swift
//  ProjectR
//
//  Created by Niell Agenbag on 2017/07/12.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import Material
import PureLayout

class signInXController: UIViewController {
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.attributedText = NSAttributedString(string: "Project R", attributes: Style.extra_large_blue_grey)
        return lbl
    }()
    
    let headingLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.attributedText = NSAttributedString(string: "LOGIN", attributes: Style.heading3)
        return lbl
    }()
    
    let nameEntry: TextField = {
        let entry = TextField()
        entry.translatesAutoresizingMaskIntoConstraints = false
        entry.placeholder = "Name & Surname"
        entry.markedTextStyle = Style.heading3
        return entry
    }()
    
    let emailEntry: TextField = {
        let entry = TextField()
        entry.translatesAutoresizingMaskIntoConstraints = false
        entry.placeholder = "Email"
        entry.markedTextStyle = Style.heading3
        return entry
    }()
    
    let googleButton: GIDSignInButton = {
        let btn = GIDSignInButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.colorScheme  = GIDSignInButtonColorScheme.dark
        return btn
    }()
    
    lazy var nextButton:Button = {
       let btn = Button()
        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.setAttributedTitle(NSAttributedString(string: "NEXT", attributes: Style.heading3), for: .normal)
        btn.setTitle("NEXT", for: .normal)
        btn.backgroundColor = UIColor.retroBlack
        btn.layer.cornerRadius = 2
        btn.layer.borderWidth = 2
        btn.titleLabel?.textColor = UIColor.retroGreen
        btn.tintColor = UIColor.retroGreen
        btn.addTarget(self, action: #selector(signInXController.onNext), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.retroGrey
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        view.addSubview(titleLabel)
        view.addSubview(headingLabel)
        view.addSubview(nameEntry)
        view.addSubview(emailEntry)
        view.addSubview(googleButton)
        view.addSubview(nextButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        titleLabel.frame = CGRect(x: (Screen.width - titleLabel.intrinsicContentSize.width)/2, y: 80, width: titleLabel.intrinsicContentSize.width, height: titleLabel.intrinsicContentSize.height)
        
//        headingLabel.frame = CGRect(x: (Screen.width - headingLabel.intrinsicContentSize.width)/2, y: titleLabel.frame.bottom + 20, width: headingLabel.intrinsicContentSize.width, height: headingLabel.intrinsicContentSize.height)
        
//        nameEntry.frame = CGRect(x: (Screen.width - nameEntry.intrinsicContentSize.width)/2, y: headingLabel.frame.bottom + 20, width: nameEntry.intrinsicContentSize.width, height: nameEntry.frame.height)
//        
//        emailEntry.frame = CGRect(x: (Screen.width - emailEntry.intrinsicContentSize.width)/2, y: nameEntry.frame.bottom, width: emailEntry.intrinsicContentSize.width, height: emailEntry.intrinsicContentSize.height)
//        
//        googleButton.frame = CGRect(x: Screen.width - googleButton.intrinsicContentSize.width, y: emailEntry.frame.bottom + 20, width: googleButton.intrinsicContentSize.width, height: googleButton.intrinsicContentSize.height)
        
        headingLabel.frame = CGRect.init(x: 40, y: titleLabel.frame.bottom + 60, width: Screen.width - 80, height: 40)
        
        nameEntry.frame = CGRect(x: 40, y: headingLabel.frame.bottom + 20 , width: Screen.width - 80, height: 40)
        
        emailEntry.frame = CGRect(x: 40, y: nameEntry.frame.bottom + 20, width: Screen.width - 80, height: 40)
        
        googleButton.frame = CGRect(x: 40, y: emailEntry.frame.bottom + 20, width: Screen.width - 80, height: 500)
        
        nextButton.frame = CGRect(x: 40, y: googleButton.frame.bottom + 60, width: Screen.width - 80, height: 40)
    }
}

/* event handlers */
extension signInXController {
    func onNext() {
        (UIApplication.shared.delegate as! AppDelegate).SetNavigationRoot(rootController: profileCreateController())
    }
}

extension signInXController: GIDSignInUIDelegate {
    
}

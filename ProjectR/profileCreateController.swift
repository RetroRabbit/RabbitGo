//
//  profileCreateController.swift
//  ProjectR
//
//  Created by Niell Agenbag on 2017/07/13.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//
import Foundation
import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import Material
import PureLayout

class profileCreateController: UIViewController{
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.attributedText = NSAttributedString(string: "Project R", attributes: Style.extra_large_blue_grey)
        return lbl
    }()
    
    private let headingLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.attributedText = NSAttributedString(string: "LOGIN", attributes: Style.heading3)
        return lbl
    }()
    
    private let universityEntry: TextField = {
        let entry = TextField()
        entry.translatesAutoresizingMaskIntoConstraints = false
        entry.placeholder = "University"
        entry.markedTextStyle = Style.heading3
        entry.keyboardType = UIKeyboardType.numberPad
        return entry
    }()
    
    private let degreeEntry: TextField = {
        let entry = TextField()
        entry.translatesAutoresizingMaskIntoConstraints = false
        entry.placeholder = "Course/Degree"
        entry.markedTextStyle = Style.heading3
        entry.keyboardType = UIKeyboardType.numberPad
        return entry
    }()
    
    private let yearEntry: TextField = {
        let entry = TextField()
        entry.translatesAutoresizingMaskIntoConstraints = false
        entry.placeholder = "Year"
        entry.markedTextStyle = Style.heading3
        entry.keyboardType = UIKeyboardType.numberPad
        return entry
    }()
    
    private lazy var loginButton:Button = {
        let btn = Button()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("LOGIN", for: .normal)
        btn.backgroundColor = UIColor.retroBlack
        btn.layer.cornerRadius = 2
        btn.layer.borderWidth = 2
        btn.titleLabel?.textColor = UIColor.retroGreen
        btn.tintColor = UIColor.retroGreen
        btn.addTarget(self, action: #selector(onLogin), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        view.backgroundColor = UIColor.retroGrey
        view.addSubview(headingLabel)
        view.addSubview(universityEntry)
        view.addSubview(degreeEntry)
        view.addSubview(yearEntry)
        view.addSubview(loginButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        titleLabel.frame = CGRect(x: (Screen.width - titleLabel.intrinsicContentSize.width)/2, y: 80, width: titleLabel.intrinsicContentSize.width, height: titleLabel.intrinsicContentSize.height)
        
        headingLabel.frame = CGRect.init(x: 40, y: titleLabel.frame.bottom + 60, width: Screen.width - 80, height: 40)
        
        universityEntry.frame = CGRect(x: 40, y: headingLabel.frame.bottom + 20 , width: Screen.width - 80, height: 40)
        
        degreeEntry.frame = CGRect(x: 40, y: universityEntry.frame.bottom + 20, width: Screen.width - 80, height: 40)
        
        yearEntry.frame = CGRect(x: 40, y: degreeEntry.frame.bottom + 20, width: Screen.width - 80, height: 40)
        
        loginButton.frame = CGRect(x: 40, y: yearEntry.frame.bottom + 60, width: Screen.width - 80, height: 40)
    }
}

extension profileCreateController {
    func onLogin() {
        (UIApplication.shared.delegate as! AppDelegate).SetNavigationRoot(rootController: gameInfoController())
    }
}

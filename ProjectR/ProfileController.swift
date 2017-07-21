//
//  ProfileController.swift
//  ProjectR
//
//  Created by Wesley Buck on 2017/07/17.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import Foundation
import UIKit
import Material

class ProfileController: UIViewController {
    static let instance = ProfileController()
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.attributedText = NSAttributedString(string: "Project R", attributes: Style.extra_large_blue_grey)
        return lbl
    }()
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.attributedText = NSAttributedString(string: "Name Surname", attributes: Style.extra_large_blue_grey)
        return lbl
    }()
    
    let subTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.attributedText = NSAttributedString(string: "- RABBITEER -", attributes: Style.extra_large_blue_grey)
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
    
    
    let universityEntry: TextField = {
        let entry = TextField()
        entry.translatesAutoresizingMaskIntoConstraints = false
        entry.placeholder = "University"
        entry.markedTextStyle = Style.heading3
        return entry
    }()
    
    
    let degreeEntry: TextField = {
        let entry = TextField()
        entry.translatesAutoresizingMaskIntoConstraints = false
        entry.placeholder = "Course/Degree"
        entry.markedTextStyle = Style.heading3
        return entry
    }()
    
    
    let yearEntry: TextField = {
        let entry = TextField()
        entry.translatesAutoresizingMaskIntoConstraints = false
        entry.placeholder = "Year"
        entry.markedTextStyle = Style.heading3
        return entry
    }()
    
    lazy var editButton:Button = {
        let btn = Button()
        btn.translatesAutoresizingMaskIntoConstraints = false
        //        btn.setAttributedTitle(NSAttributedString(string: "NEXT", attributes: Style.heading3), for: .normal)
        btn.setTitle("EDIT", for: .normal)
        btn.backgroundColor = UIColor.retroBlack
        btn.layer.cornerRadius = 2
        btn.layer.borderWidth = 2
        btn.titleLabel?.textColor = UIColor.retroGreen
        btn.tintColor = UIColor.retroGreen
        btn.addTarget(self, action: #selector(SignInController.onNext), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        //super.init()
        //super.init(hiding: NavigationHide.toBottom)
        navigationController?.title = "Leaderboard Position #43"
        tabBarItem.title = "My Profile"
        tabBarItem.image = Material.Icon.pen
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = UIColor.retroGrey
        
        view.addSubview(titleLabel)
        view.addSubview(nameLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(nameEntry)
        view.addSubview(emailEntry)
        view.addSubview(universityEntry)
        view.addSubview(degreeEntry)
        view.addSubview(yearEntry)
        view.addSubview(editButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //Title Section:
        titleLabel.frame = CGRect(x: (Screen.width - titleLabel.intrinsicContentSize.width)/2, y: 120, width: titleLabel.intrinsicContentSize.width, height: titleLabel.intrinsicContentSize.height)
        
        nameLabel.frame = CGRect(x: (Screen.width - nameLabel.intrinsicContentSize.width)/2, y: titleLabel.frame.bottom + 10, width: nameLabel.intrinsicContentSize.width, height: nameLabel.intrinsicContentSize.height)
        
        subTitleLabel.frame = CGRect(x: (Screen.width - subTitleLabel.intrinsicContentSize.width)/2, y: nameLabel.frame.bottom + 10, width: subTitleLabel.intrinsicContentSize.width, height: subTitleLabel.intrinsicContentSize.height)
        
        //Entries Section:
        nameEntry.frame = CGRect(x: 40, y: subTitleLabel.frame.bottom + 40, width: Screen.width - 80, height: 40)
        
        emailEntry.frame = CGRect(x: 40, y: nameEntry.frame.bottom + 40, width: Screen.width - 80, height: 40)
        
        universityEntry.frame = CGRect(x: 40, y: emailEntry.frame.bottom + 40, width: Screen.width - 80, height: 40)
        
        degreeEntry.frame = CGRect(x: 40, y: universityEntry.frame.bottom + 40, width: Screen.width - 80, height: 40)
        
        yearEntry.frame = CGRect(x: 40, y: degreeEntry.frame.bottom + 40, width: Screen.width - 80, height: 40)
        
        //edit button:
        editButton.frame = CGRect(x: 40, y: yearEntry.frame.bottom + 40, width: Screen.width - 80, height: 40)
    }
}

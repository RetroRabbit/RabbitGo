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

class ProfileController: UIViewController, UIScrollViewDelegate {
    fileprivate let scrollView = UIScrollView(forAutoLayout: ())
    
    static let instance = ProfileController()
    
    fileprivate var imgProfilePlaceholder: UIImageView
    /*
    let titleLabel: UILabel = {
        let lbl = UILabel()
//        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.attributedText = NSAttributedString(string: "Project R", attributes: Style.extra_large_blue_grey)
        return lbl
    }()
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
//        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.attributedText = NSAttributedString(string: "Name Surname", attributes: Style.extra_large_blue_grey)
        return lbl
    }()*/
    
    let subTitleLabel: UILabel = {
        let lbl = UILabel()
//        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.attributedText = NSAttributedString(string: "- RABBITEER -", attributes: Style.extra_large_blue_grey)
        return lbl
    }()
    
    let nameEntry: ProjectRTextField = {
        let entry = ProjectRTextField()
        entry.placeholder = "Name & Surname"
        return entry
    }()
    
    
    let emailEntry: ProjectRTextField = {
        let entry = ProjectRTextField()
        entry.placeholder = "Email"
        return entry
    }()
    
    
    let universityEntry: ProjectRTextField = {
        let entry = ProjectRTextField()
        entry.placeholder = "University"
        return entry
    }()
    
    
    let degreeEntry: ProjectRTextField = {
        let entry = ProjectRTextField()
        entry.placeholder = "Course/Degree"
        return entry
    }()
    
    
    let yearEntry: ProjectRTextField = {
        let entry = ProjectRTextField()
        entry.placeholder = "Year"
        return entry
    }()
    
    lazy var editButton:ProjectRButton = {
        let btn = ProjectRButton()
        btn.setTitle("EDIT", for: .normal)
        btn.addTarget(self, action: #selector(SignInController.onNext), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    init() {
        imgProfilePlaceholder = UIImageView(image: UIImage(named: "image_placeholder"))
        imgProfilePlaceholder.contentMode = .scaleAspectFit
        imgProfilePlaceholder.clipsToBounds = true
        
        super.init(nibName: nil, bundle: nil)
//        super.init()
//        super.init(hidd)
//        super.init(hiding: NavigationHide.toBottom)
        navigationController?.title = "Leaderboard Position #43"
        tabBarItem.title = "My Profile"
        tabBarItem.image = Material.Icon.pen
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = Style.color.grey_dark
        
        view.addSubview(scrollView)
        scrollView.delegate = self
        
//        scrollView.addSubview(titleLabel)
//        scrollView.addSubview(nameLabel)
        scrollView.addSubview(subTitleLabel)
        scrollView.addSubview(imgProfilePlaceholder)
        scrollView.addSubview(nameEntry)
        scrollView.addSubview(emailEntry)
        scrollView.addSubview(universityEntry)
        scrollView.addSubview(degreeEntry)
        scrollView.addSubview(yearEntry)
        scrollView.addSubview(editButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.autoPinEdgesToSuperviewEdges()
        
        //Title Section:
//        titleLabel.frame = CGRect(x: (Screen.width - titleLabel.intrinsicContentSize.width)/2, y: 20, width: titleLabel.intrinsicContentSize.width, height: titleLabel.intrinsicContentSize.height)
        
//        nameLabel.frame = CGRect(x: (Screen.width - nameLabel.intrinsicContentSize.width)/2, y: titleLabel.frame.bottom + 10, width: nameLabel.intrinsicContentSize.width, height: nameLabel.intrinsicContentSize.height)
        
//        subTitleLabel.frame = CGRect(x: (Screen.width - subTitleLabel.intrinsicContentSize.width)/2, y: nameLabel.frame.bottom + 5, width: subTitleLabel.intrinsicContentSize.width, height: subTitleLabel.intrinsicContentSize.height)
        
        imgProfilePlaceholder.frame = CGRect(x: Screen.width/2 - imgProfilePlaceholder.intrinsicContentSize.width/2, y: 20, width: imgProfilePlaceholder.frame.width, height: imgProfilePlaceholder.frame.height)
        
        //Entries Section:
        nameEntry.frame = CGRect(x: 40, y: imgProfilePlaceholder.frame.bottom + 40, width: Screen.width - 80, height: 40)
        
        emailEntry.frame = CGRect(x: 40, y: nameEntry.frame.bottom + 40, width: Screen.width - 80, height: 40)
        
        universityEntry.frame = CGRect(x: 40, y: emailEntry.frame.bottom + 40, width: Screen.width - 80, height: 40)
        
        degreeEntry.frame = CGRect(x: 40, y: universityEntry.frame.bottom + 40, width: Screen.width - 80, height: 40)
        
        yearEntry.frame = CGRect(x: 40, y: degreeEntry.frame.bottom + 40, width: Screen.width - 80, height: 40)
        
        //edit button:
        editButton.frame = CGRect(x: 40, y: yearEntry.frame.bottom + 40, width: Screen.width - 80, height: Style.button_height)
        
        scrollView.contentSize = CGSize(width: Screen.width, height: editButton.frame.bottom)
    }
}

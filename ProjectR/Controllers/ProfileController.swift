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
    
    private let imgProfilePlaceholder: UIImageView = {
        let placeholder = UIImageView(image: UIImage(named: "image_placeholder"))
        placeholder.contentMode = .scaleAspectFit
        placeholder.clipsToBounds = true
        return placeholder
        
    }()
    
    private let imgChangeProfile: UIImageView = {
        let changeImg = UIImageView(image: UIImage(named: "change_image"))
        changeImg.contentMode = .scaleAspectFit
        changeImg.clipsToBounds = true
        return changeImg
        
    }()
    
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
    
//    private let subTitleLabel: UILabel = {
//        let lbl = UILabel()
////        lbl.translatesAutoresizingMaskIntoConstraints = false
//        lbl.attributedText = NSAttributedString(string: "- RABBITEER -", attributes: Style.extra_large_blue_grey)
//        return lbl
//    }()
//    
    private let nameEntry: ProjectRTextField = {
        let entry = ProjectRTextField()
        entry.placeholder = "Name & Surname"
        return entry
    }()
    
    
    private let emailEntry: ProjectRTextField = {
        let entry = ProjectRTextField()
        entry.placeholder = "Email"
        return entry
    }()
    
    
    private let universityEntry: ProjectRTextField = {
        let entry = ProjectRTextField()
        entry.placeholder = "University"
        return entry
    }()
    
    
    private let degreeEntry: ProjectRTextField = {
        let entry = ProjectRTextField()
        entry.placeholder = "Course/Degree"
        return entry
    }()
    
    
    private let yearEntry: ProjectRTextField = {
        let entry = ProjectRTextField()
        entry.placeholder = "Year"
        return entry
    }()
    
    lazy var editButton:ProjectRButton = {
        let btn = ProjectRButton()
        btn.setTitle("SAVE", for: .normal)
        btn.addTarget(self, action: #selector(SignInController.onNext), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    init() {
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
        
//        scrollView.addSubview(titleLabel)
//        scrollView.addSubview(nameLabel)
//        scrollView.addSubview(subTitleLabel)
        scrollView.addSubview(imgProfilePlaceholder)
        scrollView.addSubview(imgChangeProfile)
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
        
        let x = (Screen.width - imgProfilePlaceholder.intrinsicContentSize.width)/2
        imgProfilePlaceholder.frame = CGRect(x: x, y: 20, width: imgProfilePlaceholder.frame.width, height: imgProfilePlaceholder.frame.height)
//        imgChangeProfile.frame = CGRect(x: 20, y: 20, width: imgChangeProfile.frame.width, height: imgChangeProfile.frame.height)
        
        //Entries Section:
        nameEntry.frame = CGRect(x: Style.input_center, y: imgProfilePlaceholder.frame.bottom + 40, width: Style.input_width, height: 40)
        
        emailEntry.frame = CGRect(x: Style.input_center, y: nameEntry.frame.bottom + 40, width: Style.input_width, height: 40)
        
        universityEntry.frame = CGRect(x: Style.input_center, y: emailEntry.frame.bottom + 40, width: Style.input_width, height: 40)
        
        degreeEntry.frame = CGRect(x: Style.input_center, y: universityEntry.frame.bottom + 40, width: Style.input_width, height: 40)
        
        yearEntry.frame = CGRect(x: Style.input_center, y: degreeEntry.frame.bottom + 40, width: Style.input_width, height: 40)
        
        //edit button:
        editButton.frame = CGRect(x: 40, y: yearEntry.frame.bottom + 40, width: Screen.width - 80, height: Style.button_height)
        
        scrollView.contentSize = CGSize(width: Screen.width, height: editButton.frame.bottom)
    }
}
//
//extension ProfileController {
//    
//}

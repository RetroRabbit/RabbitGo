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
import Icomoon

class ProfileController: UIViewNavigationController {
    fileprivate let scrollView = UIScrollView(forAutoLayout: ())
    
    static let instance = ProfileController()
    
    private let lblHeading: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.attributedText = NSAttributedString(string: "Profile", attributes: Style.avenirh_extra_large_white)
        return label
    }()
    
    private let imgViewDivider = UIImageView(image: UIImage(named: "textfield_line"))
    
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
        super.init()
        navigationController?.title = "Leaderboard Position #43"
        tabBarItem.setTitleTextAttributes(Style.avenirh_xsmall_white_center, for: .normal)
        tabBarItem.title = "My Profile"
        tabBarItem.image = UIImage.iconWithName(Icomoon.Icon.Profile, textColor: Material.Color.white, fontSize: 20).withRenderingMode(.alwaysOriginal)
        tabBarItem.selectedImage = UIImage.iconWithName(Icomoon.Icon.Profile, textColor: Style.color.green, fontSize: 20).withRenderingMode(.alwaysOriginal)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = Style.color.grey_dark
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        scrollView.addSubview(lblHeading)
        scrollView.addSubview(imgViewDivider)
        scrollView.addSubview(imgProfilePlaceholder)
        scrollView.addSubview(imgChangeProfile)
        scrollView.addSubview(nameEntry)
        scrollView.addSubview(emailEntry)
        scrollView.addSubview(universityEntry)
        scrollView.addSubview(degreeEntry)
        scrollView.addSubview(yearEntry)
        scrollView.addSubview(editButton)
    }
    
    override func prepareToolbar() {
        setTitle("Leaderboard Position #43", subtitle: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.autoPinEdgesToSuperviewEdges()
        
        lblHeading.preferredMaxLayoutWidth = Style.input_width
        lblHeading.frame = CGRect(x: Style.input_center, y: 20, width: Style.input_width, height: lblHeading.intrinsicContentSize.height)
        
        imgViewDivider.frame = CGRect(x: Style.input_center, y: lblHeading.frame.bottom - 40, width: Style.input_width, height: imgViewDivider.intrinsicContentSize.height)
        
        let x = (Screen.width - imgProfilePlaceholder.intrinsicContentSize.width)/2
        imgProfilePlaceholder.frame = CGRect(x: x, y: imgViewDivider.frame.bottom + 20, width: imgProfilePlaceholder.frame.width, height: imgProfilePlaceholder.frame.height)
        
        imgChangeProfile.frame = CGRect(x: imgProfilePlaceholder.frame.right - 36, y: imgProfilePlaceholder.frame.bottom - 36, width: 36, height: 36)
        
        
        //Entries Section:
        nameEntry.frame = CGRect(x: Style.input_center, y: imgProfilePlaceholder.frame.bottom + 40, width: Style.input_width, height: 40)
        
        emailEntry.frame = CGRect(x: Style.input_center, y: nameEntry.frame.bottom + 40, width: Style.input_width, height: 40)
        
        universityEntry.frame = CGRect(x: Style.input_center, y: emailEntry.frame.bottom + 40, width: Style.input_width, height: 40)
        
        degreeEntry.frame = CGRect(x: Style.input_center, y: universityEntry.frame.bottom + 40, width: Style.input_width, height: 40)
        
        yearEntry.frame = CGRect(x: Style.input_center, y: degreeEntry.frame.bottom + 40, width: Style.input_width, height: 40)
        
        //edit button:
        editButton.frame = CGRect(x: 40, y: yearEntry.frame.bottom + 40, width: Screen.width - 80, height: Style.button_height)
        
        scrollView.contentSize = CGSize(width: Screen.width, height: editButton.frame.bottom + 20)
    }
}

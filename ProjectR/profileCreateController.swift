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

class profileCreateController: BaseSignInController{
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        headingLabel.attributedText = NSAttributedString(string: "INFO", attributes: Style.rhino_large_white)
        
        view.addSubview(universityEntry)
        view.addSubview(degreeEntry)
        view.addSubview(yearEntry)
        
        nextButton.addTarget(self, action: #selector(onLogin), for: UIControlEvents.touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        universityEntry.frame = CGRect(x: 40, y: headingLabel.frame.bottom + 30 , width: Screen.width - 80, height: 40)
        
        degreeEntry.frame = CGRect(x: 40, y: universityEntry.frame.bottom + 30, width: Screen.width - 80, height: 40)
        
        yearEntry.frame = CGRect(x: 40, y: degreeEntry.frame.bottom + 30, width: Screen.width - 80, height: 40)
    }
}

extension profileCreateController {
    func onLogin() {
       // (UIApplication.shared.delegate as! AppDelegate).SetNavigationRoot(rootController: gameInfoController())
    }
}

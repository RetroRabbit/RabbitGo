//
//  signInController.swift
//  ProjectR
//
//  Created by Henko on 2017/07/09.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import JVFloatLabeledTextField

class signInController: UIViewController, GIDSignInUIDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.retroGrey
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Project R"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 35)
        titleLabel.textColor = UIColor.retroBlack
        
        view.addSubview(titleLabel)
        
        view.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 80))
        
        let headingLabel = UILabel()
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        headingLabel.text = "LOGIN"
        headingLabel.font = UIFont.boldSystemFont(ofSize: 25)
        headingLabel.textColor = UIColor.retroBlack
        
        view.addSubview(headingLabel)
        
        view.addConstraint(NSLayoutConstraint(item: headingLabel, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 50))
        view.addConstraint(NSLayoutConstraint(item: headingLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: titleLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 100))
        view.addConstraint(NSLayoutConstraint(item: headingLabel, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.right, multiplier: 1, constant: -10))
        
        
        let nameEntry = JVFloatLabeledTextField()
        nameEntry.translatesAutoresizingMaskIntoConstraints = false
        nameEntry.placeholder = "Name & Surname"
        nameEntry.floatingLabelTextColor = UIColor.retroBlack
        nameEntry.floatingLabelActiveTextColor = UIColor.retroGreen
        nameEntry.floatingLabelFont = UIFont.boldSystemFont(ofSize: 20)
        nameEntry.font = UIFont.systemFont(ofSize: 16)
        nameEntry.textColor = UIColor.retroBlack
        
        let emailEntry = JVFloatLabeledTextField()
        emailEntry.translatesAutoresizingMaskIntoConstraints = false
        emailEntry.placeholder = "Email"
        emailEntry.floatingLabelTextColor = UIColor.retroBlack
        emailEntry.floatingLabelActiveTextColor = UIColor.retroGreen
        emailEntry.floatingLabelFont = UIFont.boldSystemFont(ofSize: 20)
        emailEntry.font = UIFont.systemFont(ofSize: 16)
        emailEntry.textColor = UIColor.retroBlack
        
        view.addSubview(nameEntry)
        view.addSubview(emailEntry)
        
        view.addConstraint(NSLayoutConstraint(item: nameEntry, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: headingLabel, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: nameEntry, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: headingLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 20))
        view.addConstraint(NSLayoutConstraint(item: nameEntry, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.right, multiplier: 1, constant: -50))
        
        view.addConstraint(NSLayoutConstraint(item: emailEntry, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: headingLabel, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: emailEntry, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: nameEntry, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 10))
        view.addConstraint(NSLayoutConstraint(item: emailEntry, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.right, multiplier: 1, constant: -50))
        
        let googleButton = GIDSignInButton()
        googleButton.translatesAutoresizingMaskIntoConstraints = false
        googleButton.colorScheme = GIDSignInButtonColorScheme.dark
        
        view.addSubview(googleButton)
        
        view.addConstraint(NSLayoutConstraint(item: googleButton, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: headingLabel, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: googleButton, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: emailEntry, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 20))
        view.addConstraint(NSLayoutConstraint(item: googleButton, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.right, multiplier: 1, constant: -50))
        
        let nextButton = UIButton(type: UIButtonType.roundedRect)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("NEXT", for: UIControlState.normal)
        nextButton.backgroundColor = UIColor.retroBlack
        nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        nextButton.layer.cornerRadius = 2
        nextButton.layer.borderWidth = 2
        nextButton.titleLabel?.textColor = UIColor.retroGreen
        nextButton.tintColor = UIColor.retroGreen
        nextButton.addTarget(self, action: #selector(signInController.onNext), for: UIControlEvents.touchUpInside)
        
        view.addSubview(nextButton)
        
        view.addConstraint(NSLayoutConstraint(item: nextButton, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: nextButton, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: -40))
        view.addConstraint(NSLayoutConstraint(item: nextButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 100))
        
    }
    
    func onNext() {
        (UIApplication.shared.delegate as! AppDelegate).SetNavigationRoot(rootController: homeController())
    }
}

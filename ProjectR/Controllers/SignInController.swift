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
import RxSwift

class SignInController: BaseSignInController, UITextFieldDelegate {
    /* Data */
    let userDetails = Notification.Name(rawValue:"UserDetails")
    
    /*UI*/
    fileprivate let txtName: ProjectRTextField = {
        let entry = ProjectRTextField()
        entry.placeholder = "Name & Surname"
        return entry
    }()
    
    fileprivate let txtEmail: ProjectRTextField = {
        let entry = ProjectRTextField()
        entry.placeholder = "Email"
        entry.autocapitalizationType = .none
        entry.tag = 1
        return entry
    }()
    
    private lazy var facebookButton: ProjectRButton = {
        let btn = ProjectRButton()
        btn.setTitle("FACEBOOK", for: .normal)
        btn.addTarget(self, action: #selector(onFacebook), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    private lazy var googleButton: ProjectRButton = {
        let btn = ProjectRButton()
        btn.setTitle("GOOGLE +", for: .normal)
        btn.addTarget(self, action: #selector(onGoogle), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        headingLabel.attributedText = NSAttributedString(string: "LOGIN", attributes: Style.rhino_large_white)
        
        view.addSubview(txtName)
        view.addSubview(txtEmail)
        view.addSubview(facebookButton)
        view.addSubview(googleButton)
        
        txtName.delegate = self
        txtName.addTarget(self, action: #selector(onNameChanged), for: .editingChanged)
        txtEmail.delegate = self
        txtEmail.addTarget(self, action: #selector(onEmailChanged), for: .editingChanged)
        
        nextButton.addTarget(self, action: #selector(SignInController.onNext), for: UIControlEvents.touchUpInside)
        
        // Get authenticated user details via notification center from AppDelegate
        let nc = NotificationCenter.default
        nc.addObserver(forName: userDetails, object:nil, queue:nil, using: onAuthenticate)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        txtName.frame = CGRect(x: 30, y: headingLabel.frame.bottom + 30 , width: Screen.width - 60, height: 40)
        
        txtEmail.frame = CGRect(x: 30, y: txtName.frame.bottom + 30, width: Screen.width - 60, height: 40)
        
        let width = Screen.width - (Style.button_width * 2) - 20
        
        facebookButton.frame = CGRect(x: width/2, y: txtEmail.frame.bottom + 30, width: Style.button_width, height: Style.button_height)
        
        googleButton.frame = CGRect(x: facebookButton.frame.right + 20, y: txtEmail.frame.bottom + 30, width: Style.button_width, height: Style.button_height)
    }
    
    func onAuthenticate(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let fullName: String = userInfo["fullName"] as? String,
            let email: String = userInfo["email"] as? String else { return }

        txtName.text = fullName
        txtEmail.text = email
        
        onNext()
    }
}

extension SignInController {
    @objc fileprivate func onNameChanged() {
        // Validate UI
        if let text = txtName.text, !text.isEmpty {
            txtName.detail = ""
            txtName.isErrorRevealed = false
        } else {
            txtName.detail = "Required"
            txtName.isErrorRevealed = true
        }
    }
    
    @objc fileprivate func onEmailChanged() {
        // Validate UI
        if let text = txtEmail.text, !text.isEmpty {
            txtEmail.detail = ""
            txtEmail.isErrorRevealed = false
        } else {
            txtEmail.detail = "Required"
            txtEmail.isErrorRevealed = true
        }
    }
}

/* event handlers */
extension SignInController {
    func onNext() {
        guard let fullname = txtName.text,
            let email = txtEmail.text,
            !fullname.isEmpty,
            !email.isEmpty
            else {
                if let fullname = txtName.text, fullname.isEmpty {
                    txtName.detail = "Required"
                    txtName.isErrorRevealed = true
                }
                
                if let email = txtEmail.text, email.isEmpty {
                    txtEmail.detail = "Required"
                    txtEmail.isErrorRevealed = true
                }
                return
        }
        
        Auth.auth().createUser(withEmail: email, password: email) { [weak self] (user, error) in
            if let _ = error {
                Auth.auth().signIn(withEmail: email, password: email, completion: { (user, error) in
                    if let error = error {
                        NSLog("❌ Firebase SigIn error - \(error.localizedDescription)")
                    } else {
                        self?.checkRedirect()
                    }
                })
            } else {
                self?.checkRedirect()
            }
        }
    }
    
    func onGoogle() {
        GIDSignIn.sharedInstance().signIn()
    }
    
    func onFacebook() {
        
    }
    
    private func checkRedirect() {
        guard let fullname = txtName.text,
            !fullname.isEmpty
            else {
                if let fullname = txtName.text, fullname.isEmpty {
                    txtName.isValid = false
                }
                return
        }
        
        refCurrentUser().observeSingleEvent(of: DataEventType.value, with: { [weak self] (snapshot) in
            if (!snapshot.hasChildren()) {
                snapshot.ref.setValue(Player(email: auth.currentUser?.email, displayName: fullname).formatted(), withCompletionBlock: { (error, ref) in
                    self?.createQuestions()
                })
            } else {
                if !snapshot.hasChild("questions") {
                    self?.createQuestions()
                } else {
                    self?.navigateToDetails()
                }
            }
        })
    }
    
    private func createQuestions() {
        refQuestions.observeSingleEvent(of: .value, with: { (questionSnapshot) in
            for child in questionSnapshot.children {
                if let snap = child as? DataSnapshot {
                    refCurrentUserQuestions().child(snap.key).setValue(PlayerQuestion(state: QuestionState.locked.rawValue).formatted(), withCompletionBlock: { (err, ref) in
                        if let error = err {
                            NSLog("❌ Question creation error - \(error.localizedDescription)\nRef: \(ref)")
                        }
                    })
                }
            }
        })
        navigateToDetails()
    }
    
    private func navigateToDetails() {
        if isRabbit(user: auth.currentUser) {
            (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = TabNavigationController()
        } else {
            refCurrentUser().observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
                if let year = snapshot.childSnapshot(forPath: "year").value as? String,
                    let degree = snapshot.childSnapshot(forPath: "degree").value as? String,
                    let university = snapshot.childSnapshot(forPath: "university").value as? String,
                    year.isEmpty, degree.isEmpty, university.isEmpty {
                    self.navigationController?.pushViewController(profileCreateController(), animated: true)
                } else {
                    self.navigationController?.pushViewController(WelcomeController(), animated: true)
                }
            })
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        if textField.tag == 0 && txtEmail.text == "" {
            _ = txtEmail.becomeFirstResponder()
        }
        return false
    }
}

extension SignInController: GIDSignInUIDelegate {
    
}

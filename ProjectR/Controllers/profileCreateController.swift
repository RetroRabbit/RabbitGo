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
import RxSwift

class profileCreateController: BaseSignInController {
    /* Data */
    fileprivate static var university: [AutoComplete] = []
    fileprivate static var degree: [AutoComplete] = []
    fileprivate static var year: [AutoComplete] = []
    
    fileprivate var universityProvider: UniversityAutoCompleteProvider = UniversityAutoCompleteProvider()
    fileprivate var degreeProvider: DegreeAutoCompleteProvider = DegreeAutoCompleteProvider()
    fileprivate var yearProvider: YearAutoCompleteProvider = YearAutoCompleteProvider()
    
    /* UI */
    fileprivate lazy var txtUniversity: AutoCompleteTextField = {
        let txt = AutoCompleteTextField()
        txt.placeholder = "University"
        return txt
    }()
    
    fileprivate lazy var txtDegree: AutoCompleteTextField = {
        let txt = AutoCompleteTextField()
        txt.placeholder = "Course/Degree"
        return txt
    }()
    
    fileprivate lazy var txtYear: AutoCompleteTextField = {
        let txt = AutoCompleteTextField()
        txt.placeholder = "Year"
        return txt
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refAutoComplete.observeSingleEvent(of: .value, with: { (snapShot) in
            
            for child in snapShot.childSnapshot(forPath: "universities").children {
                if let snap = child as? DataSnapshot,
                    let name = snap.childSnapshot(forPath: "name").value as? String,
                    let nick = snap.childSnapshot(forPath: "nick").value as? String {
                    profileCreateController.university.append(AutoComplete(name: name, nick: nick))
                }
            }
            
            for child in snapShot.childSnapshot(forPath: "degrees").children {
                if let snap = child as? DataSnapshot,
                    let name = snap.childSnapshot(forPath: "name").value as? String,
                    let nick = snap.childSnapshot(forPath: "nick").value as? String {
                    profileCreateController.degree.append(AutoComplete(name: name, nick: nick))
                }
            }
            
            for child in snapShot.childSnapshot(forPath: "years").children {
                if let snap = child as? DataSnapshot,
                    let name = snap.childSnapshot(forPath: "name").value as? String,
                    let nick = snap.childSnapshot(forPath: "nick").value as? String {
                    profileCreateController.year.append(AutoComplete(name: name, nick: nick))
                }
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        headingLabel.attributedText = NSAttributedString(string: "INFO", attributes: Style.rhino_large_white)
        
        view.addSubview(txtUniversity)
        txtUniversity.autoCompleteProvider = universityProvider
        txtUniversity.setupAutoComplete()
        
        view.addSubview(txtDegree)
        txtDegree.autoCompleteProvider = degreeProvider
        txtDegree.setupAutoComplete()
        
        view.addSubview(txtYear)
        txtYear.autoCompleteProvider = yearProvider
        txtYear.setupAutoComplete()
        
        txtUniversity.addTarget(self, action: #selector(onUniversityChanged), for: .editingChanged)
        txtDegree.addTarget(self, action: #selector(onDegreeChanged), for: .editingChanged)
        txtYear.addTarget(self, action: #selector(onYearChanged), for: .editingChanged)
        
        nextButton.addTarget(self, action: #selector(onLogin), for: UIControlEvents.touchUpInside)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        txtUniversity.frame = CGRect(x: 30, y: headingLabel.frame.bottom + 30 , width: Screen.width - 60, height: 40)
        
        txtDegree.frame = CGRect(x: 30, y: txtUniversity.frame.bottom + 30, width: Screen.width - 60, height: 40)
        
        txtYear.frame = CGRect(x: 30, y: txtDegree.frame.bottom + 30, width: Screen.width - 60, height: 40)
    }
}

extension profileCreateController {
    @objc fileprivate func onUniversityChanged() {
        // Validate UI
        if let text = txtUniversity.text, !text.isEmpty {
            txtUniversity.detail = ""
            txtUniversity.isErrorRevealed = false
        } else {
            txtUniversity.detail = "Required"
            txtUniversity.isErrorRevealed = true
        }
    }
    
    @objc fileprivate func onDegreeChanged() {
        // Validate UI
        if let text = txtDegree.text, !text.isEmpty {
            txtDegree.detail = ""
            txtDegree.isErrorRevealed = false
        } else {
            txtDegree.detail = "Required"
            txtDegree.isErrorRevealed = true
        }
    }
    
    @objc fileprivate func onYearChanged() {
        // Validate UI
        if let text = txtYear.text, !text.isEmpty {
            txtYear.detail = ""
            txtYear.isErrorRevealed = false
        } else {
            txtYear.detail = "Required"
            txtYear.isErrorRevealed = true
        }
    }
}

extension profileCreateController {
    func onLogin() {
        guard let university = txtUniversity.text,
            let degree = txtDegree.text,
            let year = txtYear.text,
            !university.isEmpty,
            !degree.isEmpty,
            !year.isEmpty else {
                if let fullname = txtUniversity.text, fullname.isEmpty {
                    txtUniversity.detail = "Required"
                    txtUniversity.isErrorRevealed = true
                }
                
                if let email = txtDegree.text, email.isEmpty {
                    txtDegree.detail = "Required"
                    txtDegree.isErrorRevealed = true
                }
                
                if let email = txtYear.text, email.isEmpty {
                    txtYear.detail = "Required"
                    txtYear.isErrorRevealed = true
                }
                return
        }
        
        refCurrentUser().observeSingleEvent(of: .value, with: { [weak self] (snapshot) in
            guard let score =  snapshot.childSnapshot(forPath: "score").value as? Int else { return }
            if  let email = snapshot.childSnapshot(forPath: "email").value as? String,
                let displayName = snapshot.childSnapshot(forPath: "displayName").value as? String {
                var player = Player(email: email, displayName: displayName, university: university, degree: degree, year: year, score: Int64(score)).formatted()
                var questions: [String:Any] = [:]
                snapshot.childSnapshot(forPath: "questions").children.allObjects.forEach({ object in
                    if let question = object as? DataSnapshot {
                        questions[question.key] = PlayerQuestion.decode(snapshot: question).formatted()
                    }
                })
                
                player["questions"] = questions
                
                snapshot.ref.setValue(player, withCompletionBlock: { [weak self] _ in
                    self?.navigationController?.pushViewController(WelcomeController(), animated: true)
                })
            }
        })
    }
}

final class UniversityAutoCompleteProvider: AutoCompleteProvider {
    func provideSuggestionsForAutoCompleteTextField(_ textField: AutoCompleteTextField, forString string: String, toCallback callback: @escaping ([AutoCompleteTextField.Suggestion]) -> Void) {
        callback(profileCreateController.university.filter { object -> Bool in
            return object.toString().lowercased().contains(string.lowercased())
            }.map({ object -> AutoCompleteTextField.Suggestion in
                return AutoCompleteTextField.Suggestion(text: object.name ?? "", subtext: object.nick ?? "")
            }))
    }
}

final class DegreeAutoCompleteProvider: AutoCompleteProvider {
    func provideSuggestionsForAutoCompleteTextField(_ textField: AutoCompleteTextField, forString string: String, toCallback callback: @escaping ([AutoCompleteTextField.Suggestion]) -> Void) {
        callback(profileCreateController.degree.filter { object -> Bool in
            return object.toString().lowercased().contains(string.lowercased())
            }.map({ object -> AutoCompleteTextField.Suggestion in
                return AutoCompleteTextField.Suggestion(text: object.name ?? "", subtext: object.nick ?? "")
            }))
    }
}

final class YearAutoCompleteProvider: AutoCompleteProvider {
    func provideSuggestionsForAutoCompleteTextField(_ textField: AutoCompleteTextField, forString string: String, toCallback callback: @escaping ([AutoCompleteTextField.Suggestion]) -> Void) {
        callback(profileCreateController.year.filter { object -> Bool in
            return object.toString().lowercased().contains(string.lowercased())
            }.map({ object -> AutoCompleteTextField.Suggestion in
                return AutoCompleteTextField.Suggestion(text: object.name ?? "", subtext: object.nick ?? "")
            }))
    }
}

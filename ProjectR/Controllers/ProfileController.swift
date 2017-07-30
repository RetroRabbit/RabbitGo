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
import Firebase

class ProfileController: UIViewNavigationController, UIImagePickerControllerDelegate {
    fileprivate let scrollView = UIScrollView(forAutoLayout: ())
    
    static let instance = ProfileController()
    fileprivate let galleryPicker = UIImagePickerController()
    fileprivate var flag = false
    
    private let imgViewDivider = UIImageView(image: UIImage(named: "textfield_line"))
    
    fileprivate static var university: [AutoComplete] = []
    fileprivate static var degree: [AutoComplete] = []
    fileprivate static var year: [AutoComplete] = []
    
    fileprivate var universityProvider: UniversityAutoCompleteProvider = UniversityAutoCompleteProvider()
    fileprivate var degreeProvider: DegreeAutoCompleteProvider = DegreeAutoCompleteProvider()
    fileprivate var yearProvider: YearAutoCompleteProvider = YearAutoCompleteProvider()
    
    private let lblHeading: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.attributedText = NSAttributedString(string: "Profile", attributes: Style.avenirh_extra_large_white)
        return label
    }()
    
    fileprivate let imgProfilePlaceholder: UIImageView = {
        let placeholder = UIImageView(image: UIImage(named: "image_placeholder"))
        placeholder.contentMode = .scaleAspectFill
        placeholder.clipsToBounds = true
        placeholder.layer.cornerRadius = 50;
        return placeholder
        
    }()
    
    private let imgChangeProfile: UIImageView = {
        let changeImg = UIImageView(image: UIImage(named: "change_image"))
        changeImg.contentMode = .scaleAspectFit
        changeImg.clipsToBounds = true
        return changeImg
        
    }()
    
    fileprivate let nameEntry: ProjectRTextField = {
        let entry = ProjectRTextField()
        entry.placeholder = "Name & Surname"
        return entry
    }()
    
    
    fileprivate let emailEntry: ProjectRTextField = {
        let entry = ProjectRTextField()
        entry.placeholder = "Email"
        entry.isEnabled = false
        return entry
    }()
    
    
    fileprivate var universityEntry: AutoCompleteTextField = {
        let entry = AutoCompleteTextField()
        //        entry.autoCompleteProvider = UniversityAutoCompleteProvider()
        entry.placeholder = "University"
        return entry
    }()
    
    
    fileprivate let degreeEntry: AutoCompleteTextField = {
        let entry = AutoCompleteTextField()
        entry.placeholder = "Course/Degree"
        return entry
    }()
    
    
    fileprivate let yearEntry: AutoCompleteTextField = {
        let entry = AutoCompleteTextField()
        entry.placeholder = "Year"
        return entry
    }()
    
    lazy var editButton:ProjectRButton = {
        let btn = ProjectRButton()
        btn.setTitle("SAVE", for: .normal)
        btn.addTarget(self, action: #selector(onSave), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    init() {
        super.init()
        tabBarItem.setTitleTextAttributes(Style.avenirh_xsmall_white_center, for: .normal)
        tabBarItem.title = "My Profile"
        tabBarItem.image = UIImage.iconWithName(Icomoon.Icon.Profile, textColor: Material.Color.white, fontSize: 20).withRenderingMode(.alwaysOriginal)
        tabBarItem.selectedImage = UIImage.iconWithName(Icomoon.Icon.Profile, textColor: Style.color.green, fontSize: 20).withRenderingMode(.alwaysOriginal)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refAutoComplete.observeSingleEvent(of: .value, with: { (snapShot) in
            
            for child in snapShot.childSnapshot(forPath: "universities").children {
                if let snap = child as? DataSnapshot,
                    let name = snap.childSnapshot(forPath: "name").value as? String,
                    let nick = snap.childSnapshot(forPath: "nick").value as? String {
                    ProfileController.university.append(AutoComplete(name: name, nick: nick))
                }
            }
            
            for child in snapShot.childSnapshot(forPath: "degrees").children {
                if let snap = child as? DataSnapshot,
                    let name = snap.childSnapshot(forPath: "name").value as? String,
                    let nick = snap.childSnapshot(forPath: "nick").value as? String {
                    ProfileController.degree.append(AutoComplete(name: name, nick: nick))
                }
            }
            
            for child in snapShot.childSnapshot(forPath: "years").children {
                if let snap = child as? DataSnapshot,
                    let name = snap.childSnapshot(forPath: "name").value as? String,
                    let nick = snap.childSnapshot(forPath: "nick").value as? String {
                    ProfileController.year.append(AutoComplete(name: name, nick: nick))
                }
            }
        })
        
        if let profileImage = profileImage {
            imgProfilePlaceholder.image = profileImage
        } else {
            currentUserProfilePic.getData(maxSize: 1 * 1024 * 1024, completion: { (data, error) in
                if let _ = error {
                } else {
                    let image = UIImage(data: data!)
                    profileImage = image
                }
            })
        }
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
        universityEntry.autoCompleteProvider = universityProvider
        universityEntry.setupAutoComplete()
        
        scrollView.addSubview(degreeEntry)
        degreeEntry.autoCompleteProvider = degreeProvider
        degreeEntry.setupAutoComplete()
        
        scrollView.addSubview(yearEntry)
        yearEntry.autoCompleteProvider = yearProvider
        yearEntry.setupAutoComplete()
        
        scrollView.addSubview(editButton)
        
        imgChangeProfile.isUserInteractionEnabled = true
        imgChangeProfile.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(uploadProfile)))
        
        nameEntry.addTarget(self, action: #selector(updateTextfields), for: .editingChanged)
        emailEntry.addTarget(self, action: #selector(updateTextfields), for: .editingChanged)
        universityEntry.addTarget(self, action: #selector(updateTextfields), for: .editingChanged)
        degreeEntry.addTarget(self, action: #selector(updateTextfields), for: .editingChanged)
        yearEntry.addTarget(self, action: #selector(updateTextfields), for: .editingChanged)
        
        refCurrentUser().observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            self.nameEntry.text = snapshot.childSnapshot(forPath: "displayName").value as? String
            self.emailEntry.text = snapshot.childSnapshot(forPath: "email").value as? String
            self.universityEntry.text = snapshot.childSnapshot(forPath: "university").value as? String
            self.degreeEntry.text = snapshot.childSnapshot(forPath: "degree").value as? String
            self.yearEntry.text = snapshot.childSnapshot(forPath: "year").value as? String
        })
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func prepareToolbar() {
        setTitle("Leaderboard Position #\(RabbiteerHomeController.instance.userObject?.individualRanking ?? 0)", subtitle: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.autoPinEdgesToSuperviewEdges()
        
        lblHeading.preferredMaxLayoutWidth = Style.input_width
        lblHeading.frame = CGRect(x: Style.input_center, y: 20, width: Style.input_width, height: lblHeading.intrinsicContentSize.height)
        
        imgViewDivider.frame = CGRect(x: Style.input_center, y: lblHeading.frame.bottom - 40, width: Style.input_width, height: imgViewDivider.intrinsicContentSize.height)
        
        let x = (Screen.width - 100)/2
        imgProfilePlaceholder.frame = CGRect(x: x, y: imgViewDivider.frame.bottom + 20, width: 100, height: 100)
        
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

extension ProfileController{
    
    func onSave(){
        flag = true
        guard let fullname = nameEntry.text,
            let email = emailEntry.text,
            let university = universityEntry.text,
            let degree = degreeEntry.text,
            let year = yearEntry.text,
            !fullname.isEmpty,
            !email.isEmpty,
            !university.isEmpty,
            !degree.isEmpty,
            !year.isEmpty
            else {
                updateTextfields()
                return
        }
        
        refCurrentUser().observeSingleEvent(of: .value, with: { (snapshot) in
            guard let score =  snapshot.childSnapshot(forPath: "score").value as? Int else { return }
            var player = Player(email: email, displayName: fullname, university: university, degree: degree, year: year, score: Int64(score)).formatted()
            var questions: [String:Any] = [:]
            snapshot.childSnapshot(forPath: "questions").children.allObjects.forEach({ object in
                if let question = object as? DataSnapshot {
                    questions[question.key] = PlayerQuestion.decode(snapshot: question).formatted()
                }
            })
            
            player["questions"] = questions
            
            snapshot.ref.setValue(player, withCompletionBlock: { [weak self] _ in
                let ac = UIAlertController(title: "Profile Updated", message: nil, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(ac, animated: true)
            })
        })
        
        if let image = imgProfilePlaceholder.image,
            let imageData: Data = UIImageJPEGRepresentation(image, 0.6) {
            let meta = StorageMetadata()
            meta.setValue("image/jpeg", forKey: "contentType")
            
            _ = currentUserProfilePic.putData(imageData, metadata: meta) { (metadata, error) in
                guard let _ = error else {
                    // Uh-oh, an error occurred!
                    return
                }
                // Metadata contains file metadata such as size, content-type, and download URL.
                self.imgProfilePlaceholder.image = image
                self.imgProfilePlaceholder.reloadInputViews()
                profileImage = image
            }
        }
        
    }
    
    func updateTextfields() {
        guard flag
            
            else{
                return
        }
        
        if let fullname = nameEntry.text, fullname.isEmpty {
            nameEntry.detail = "Required"
            nameEntry.isErrorRevealed = true
        }
        else {
            nameEntry.isErrorRevealed = false
        }
        
        if let email = emailEntry.text, email.isEmpty {
            emailEntry.detail = "Required"
            emailEntry.isErrorRevealed = true
        }
        else {
            emailEntry.isErrorRevealed = false
        }
        
        if let university = universityEntry.text, university.isEmpty {
            universityEntry.detail = "Required"
            universityEntry.isErrorRevealed = true
        }
        else {
            universityEntry.isErrorRevealed = false
        }
        
        if let degree = degreeEntry.text, degree.isEmpty {
            degreeEntry.detail = "Required"
            degreeEntry.isErrorRevealed = true
        }
        else {
            degreeEntry.isErrorRevealed = false
        }
        
        if let year = yearEntry.text, year.isEmpty {
            yearEntry.detail = "Required"
            yearEntry.isErrorRevealed = true
        }
        else {
            yearEntry.isErrorRevealed = false
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        defer {
            picker.dismiss(animated: true)
        }
        
        print(info)
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        
        imgProfilePlaceholder.image = image
        
        
        
        
    }
    
    func uploadProfile() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("can't open photo library")
            return
        }
        
        galleryPicker.sourceType = .photoLibrary
        galleryPicker.delegate = self
        present(galleryPicker, animated: true)
        
    }
    
    final class UniversityAutoCompleteProvider: AutoCompleteProvider {
        func provideSuggestionsForAutoCompleteTextField(_ textField: AutoCompleteTextField, forString string: String, toCallback callback: @escaping ([AutoCompleteTextField.Suggestion]) -> Void) {
            callback(ProfileController.university.filter { object -> Bool in
                return object.toString().lowercased().contains(string.lowercased())
                }.map({ object -> AutoCompleteTextField.Suggestion in
                    return AutoCompleteTextField.Suggestion(text: object.name ?? "", subtext: object.nick ?? "")
                }))
        }
    }
    
    final class DegreeAutoCompleteProvider: AutoCompleteProvider {
        func provideSuggestionsForAutoCompleteTextField(_ textField: AutoCompleteTextField, forString string: String, toCallback callback: @escaping ([AutoCompleteTextField.Suggestion]) -> Void) {
            callback(ProfileController.degree.filter { object -> Bool in
                return object.toString().lowercased().contains(string.lowercased())
                }.map({ object -> AutoCompleteTextField.Suggestion in
                    return AutoCompleteTextField.Suggestion(text: object.name ?? "", subtext: object.nick ?? "")
                }))
        }
    }
    
    final class YearAutoCompleteProvider: AutoCompleteProvider {
        func provideSuggestionsForAutoCompleteTextField(_ textField: AutoCompleteTextField, forString string: String, toCallback callback: @escaping ([AutoCompleteTextField.Suggestion]) -> Void) {
            callback(ProfileController.year.filter { object -> Bool in
                return object.toString().lowercased().contains(string.lowercased())
                }.map({ object -> AutoCompleteTextField.Suggestion in
                    return AutoCompleteTextField.Suggestion(text: object.name ?? "", subtext: object.nick ?? "")
                }))
        }
    }
}

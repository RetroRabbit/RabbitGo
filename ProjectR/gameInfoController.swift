//
//  gameInfoController.swift
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

class gameInfoController: UIViewController{
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.attributedText = NSAttributedString(string: "Project R", attributes: Style.extra_large_blue_grey)
        return lbl
    }()
    
    let headingLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.attributedText = NSAttributedString(string: "Dear Rabbiteer", attributes: Style.extra_large_blue_grey)
        return lbl
    }()
    
    let bodyLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.attributedText = NSAttributedString(string: "Welcome to Rabbittania! \nFor your quest today, you have to scan as many QR codes to unlock different questions about the magical Rabbittania! \n\nYou may ask any Rabbit for the answers to the answers, but you have to enter their unique Rabbit- codes to submit your answers! \n\nThe one who answers all of the questions first, WINS!", attributes: Style.body)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        return lbl
    }()
    
    let bottomLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.attributedText = NSAttributedString(string: "Good Luck!", attributes: Style.extra_large_blue_grey)
        return lbl
    }()
    
    lazy var nextButton:Button = {
        let btn = Button()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("NEXT", for: .normal)
        btn.backgroundColor = UIColor.retroBlack
        btn.layer.cornerRadius = 2
        btn.layer.borderWidth = 2
        btn.titleLabel?.textColor = UIColor.retroGreen
        btn.tintColor = UIColor.retroGreen
        btn.addTarget(self, action: #selector(onNext), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        view.backgroundColor = UIColor.retroGrey
        
        view.addSubview(titleLabel)
        view.addSubview(headingLabel)
        view.addSubview(bodyLabel)
        view.addSubview(bottomLabel)
        view.addSubview(nextButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        titleLabel.frame = CGRect(x: (Screen.width - titleLabel.intrinsicContentSize.width)/2, y: 80, width: titleLabel.intrinsicContentSize.width, height: titleLabel.intrinsicContentSize.height)
        
        headingLabel.frame = CGRect(x: (Screen.width - headingLabel.intrinsicContentSize.width)/2, y: titleLabel.frame.bottom + 10, width: headingLabel.intrinsicContentSize.width, height: headingLabel.intrinsicContentSize.height)
        
        bodyLabel.frame = CGRect(x: 30, y: headingLabel.frame.bottom + 10, width: Screen.width - 60, height: bodyLabel.intrinsicContentSize.height * 2)
        
        bottomLabel.frame = CGRect(x: (Screen.width - bottomLabel.intrinsicContentSize.width)/2, y: bodyLabel.frame.bottom, width: bottomLabel.intrinsicContentSize.width, height: bodyLabel.intrinsicContentSize.height)
        
        nextButton.frame = CGRect(x: 40, y: bottomLabel.frame.bottom, width: Screen.width - 80, height: 40)
    }
}

extension gameInfoController {
    func onNext() {
        
        (UIApplication.shared.delegate as! AppDelegate).SetNavigationRoot(rootController: PrizesController())
    }
}

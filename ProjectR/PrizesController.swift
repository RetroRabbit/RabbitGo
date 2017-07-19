//
//  PrizesController.swift
//  ProjectR
//
//  Created by Niell Agenbag on 2017/07/17.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import Material
import PureLayout


class PrizesController: UIViewController{
    
    fileprivate enum screenStates {
        case prizeOne
        case prizeTwo
        case prizeThree
        case done
    }
    
    var currentState:screenStates = screenStates.prizeOne
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.attributedText = NSAttributedString(string: "Project R", attributes: Style.extra_large_blue_grey)
        return lbl
    }()
    
    private let firstPrizeImg: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(named: "")
        imgView.tintColor = UIColor.retroBlack
        return imgView
    }()
    
    private let secondPrizeImg: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(named: "")
        imgView.tintColor = UIColor.retroBlack
        return imgView
    }()
    
    private let thirdPrizeImg: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.tintColor = UIColor.retroBlack
        return imgView
    }()
    
    private let prizeContainer:UIVIew = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = UIColor.white
        return container
    }()
    
    fileprivate let prizeTitleLBL:UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    fileprivate let prizeImg:UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(named: "")
        return imgView
    }()
    
    fileprivate let prizeDescriptionLBL:UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var nextButton:Button = {
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
        view.addSubview(firsnestPrizeImg)
        view.addSubview(secondPrizeImg)
        view.addSubview(thirdPrizeImg)
        view.addSubview(prizeContainer)
        view.addSubview(prizeTitleLBL)
        view.addSubview(prizeImg)
        view.addSubview(prizeDescriptionLBL)
        view.addSubview(nextButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        titleLabel.frame = CGRect(x: (Screen.width - titleLabel.intrinsicContentSize.width)/2, y: 120, width: titleLabel.intrinsicContentSize.width, height: titleLabel.intrinsicContentSize.height)
        
        //1st, 2nd and 3rd prize idication images:
        firstPrizeImg.frame = CGRect(x: <#T##Int#>, y: <#T##Int#>, width: <#T##Int#>, height: <#T##Int#>)
        
        secondPrizeImg.frame = CGRect(x: <#T##Int#>, y: <#T##Int#>, width: <#T##Int#>, height: <#T##Int#>)

        thirdPrizeImg.frame = CGRect(x: <#T##Int#>, y: <#T##Int#>, width: <#T##Int#>, height: <#T##Int#>)
        
        //current displaying prize:
        prizeTitleLBL.frame = CGRect(x: <#T##Int#>, y: <#T##Int#>, width: <#T##Int#>, height: <#T##Int#>)

        prizeImg.frame = CGRect(x: <#T##Int#>, y: <#T##Int#>, width: <#T##Int#>, height: <#T##Int#>)

        prizeDescriptionLBL.frame = CGRect(x: <#T##Int#>, y: <#T##Int#>, width: <#T##Int#>, height: <#T##Int#>)

        prizeContainer.frame = CGRect(x: <#T##Int#>, y: <#T##Int#>, width: <#T##Int#>, height: <#T##Int#>)

        //NextButton
        nextButton.frame = CGRect(x: 40, y: Screen.height - 50 , width: Screen.width, height: 40)
    }
}

extension PrizesController{
    func onNext(){
        switch(currentState){
        case screenStates.prizeOne:
            prizeTitleLBL.attributedText = NSAttributedString(string: "1", attributes: Style.heading_2a)
            prizeImg.image = UIImage(named: "")
            prizeDescriptionLBL.attributedText = NSAttributedString(string: "", attributes: Style.body)
            currentState = screenStates.prizeTwo
            break
        case screenStates.prizeOne:
            prizeTitleLBL.attributedText = NSAttributedString(string: "2", attributes: Style.heading_2a)
            prizeImg.image = UIImage(named: "")
            prizeDescriptionLBL.attributedText = NSAttributedString(string: "", attributes: Style.body)
            currentState = screenStates.prizeThree
            break
        case screenStates.prizeOne:
            prizeTitleLBL.attributedText = NSAttributedString(string: "3", attributes: Style.heading_2a)
            prizeImg.image = UIImage(named: "")
            prizeDescriptionLBL.attributedText = NSAttributedString(string: "", attributes: Style.body)
            currentState = screenStates.done
            break
        case screenStates.done:
            (UIApplication.shared.delegate as! AppDelegate).SetNavigationRoot(rootController: homeController())
            break
        }
    }
}

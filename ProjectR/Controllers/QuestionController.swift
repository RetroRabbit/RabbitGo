//
//  QuestionController.swift
//  ProjectR
//
//  Created by Hugo Meiring on 2017/07/27.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import Foundation
import UIKit
import PureLayout
import Material

class QuestionController: UIViewController {
    /* UI */
    fileprivate let scrollView = UIScrollView()
    fileprivate let contentView = UIView()
    
    fileprivate let vwQuestion: UIView = {
        let view = UIView()
        view.backgroundColor = Material.Color.white
        return view
    }()
    
    fileprivate let lblQuestionNumber: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "", attributes: Style.avenirh_small_grey_dark_center)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    fileprivate let lblQuestion: UILabel = {
        let label = UILabel()
        label.preferredMaxLayoutWidth = Screen.width
        label.attributedText = NSAttributedString(string: "", attributes: Style.avenirh_extra_large_grey_dark_center)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    fileprivate let imgOption1: UIImageView
    fileprivate let imgOption2: UIImageView
    fileprivate let imgOption3: UIImageView
    fileprivate let imgOption4: UIImageView
    
    fileprivate let lblOption1: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "", attributes: Style.avenirh_small_white)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    fileprivate let lblOption2: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "", attributes: Style.avenirh_small_white)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    fileprivate let lblOption3: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "", attributes: Style.avenirh_small_white)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    fileprivate let lblOption4: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "", attributes: Style.avenirh_small_white)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let tfRabbitCode: ProjectRTextField = {
        let textField = ProjectRTextField()
        textField.placeholder = "Unique Rabbit Code"
        return textField
    }()
    
    lazy var btnSubmit :ProjectRButton = {
        let btn = ProjectRButton()
        btn.setTitle("SUBMIT", for: .normal)
        btn.addTarget(self, action: #selector(SignInController.onNext), for: UIControlEvents.touchUpInside)
        return btn
    }()
    

    init(question: Question, index: Int) {
        imgOption1 = UIImageView(image: UIImage(named: "answer_square_grey"))
        imgOption1.contentMode = .scaleAspectFit
        imgOption1.clipsToBounds = true
        
        imgOption2 = UIImageView(image: UIImage(named: "answer_square_grey"))
        imgOption2.contentMode = .scaleAspectFit
        imgOption2.clipsToBounds = true
        
        imgOption3 = UIImageView(image: UIImage(named: "answer_square_grey"))
        imgOption3.contentMode = .scaleAspectFit
        imgOption3.clipsToBounds = true
        
        imgOption4 = UIImageView(image: UIImage(named: "answer_square_grey"))
        imgOption4.contentMode = .scaleAspectFit
        imgOption4.clipsToBounds = true
        
        /* Set up questions */
        lblQuestionNumber.attributedText = NSAttributedString(string: "Question #\(index)", attributes: Style.avenirh_small_grey_dark_center)
        lblQuestion.attributedText = NSAttributedString(string: question.text as String? ?? "", attributes: Style.avenirh_extra_large_grey_dark_center)
        
        if let questions = question.multiple {
            for (index, option) in questions.enumerated() {
                switch index {
                case 0:
                    lblOption1.attributedText = NSAttributedString(string: option as String, attributes: Style.avenirh_small_white)
                case 1:
                    lblOption2.attributedText = NSAttributedString(string: option as String, attributes: Style.avenirh_small_white)
                case 2:
                    lblOption3.attributedText = NSAttributedString(string: option as String, attributes: Style.avenirh_small_white)
                case 3:
                    lblOption4.attributedText = NSAttributedString(string: option as String, attributes: Style.avenirh_small_white)
                default:
                    continue
                }
            }
        }
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = Style.color.grey_dark
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.addSubview(vwQuestion)
        scrollView.addSubview(lblQuestionNumber)
        scrollView.addSubview(lblQuestion)
        
        scrollView.addSubview(imgOption1)
        scrollView.addSubview(imgOption2)
        scrollView.addSubview(imgOption3)
        scrollView.addSubview(imgOption4)
        
        scrollView.addSubview(lblOption1)
        scrollView.addSubview(lblOption2)
        scrollView.addSubview(lblOption3)
        scrollView.addSubview(lblOption4)
        
        scrollView.addSubview(tfRabbitCode)
        scrollView.addSubview(btnSubmit)
        
        btnSubmit.addTarget(self, action: #selector(onSubmit), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        let margin = Style.padding.xxl
        
        scrollView.autoPinEdgesToSuperviewEdges()
        
        lblQuestionNumber.frame = CGRect(x: 0, y: 15, width: Screen.width, height: lblQuestionNumber.intrinsicContentSize.height)
        lblQuestion.frame = CGRect(x: 0, y: lblQuestionNumber.frame.bottom + 15, width: Screen.width, height: lblQuestion.intrinsicContentSize.height)
        vwQuestion.frame = CGRect(x: 0, y: 0, width: Screen.width, height: lblQuestion.frame.bottom + 15)
        
        imgOption1.frame = CGRect(x: 0, y: vwQuestion.frame.bottom + 10, width: imgOption1.intrinsicContentSize.width, height: imgOption1.intrinsicContentSize.height)
        lblOption1.frame = CGRect(x: 0, y: imgOption1.frame.top + imgOption1.frame.height/2, width: Screen.width, height: lblOption1.intrinsicContentSize.height)
        imgOption2.frame = CGRect(x: 0, y: imgOption1.frame.bottom + 5, width: imgOption2.intrinsicContentSize.width, height: imgOption2.intrinsicContentSize.height)
        lblOption2.frame = CGRect(x: 0, y: imgOption2.frame.top + imgOption2.frame.height/2, width: Screen.width, height: lblOption2.intrinsicContentSize.height)
        imgOption3.frame = CGRect(x: 0, y: imgOption2.frame.bottom + 5, width: imgOption3.intrinsicContentSize.width, height: imgOption3.intrinsicContentSize.height)
        lblOption3.frame = CGRect(x: 0, y: imgOption3.frame.top + imgOption3.frame.height/2, width: Screen.width, height: lblOption3.intrinsicContentSize.height)
    
        if lblOption4.text != "" {
            imgOption4.frame = CGRect(x: 0, y: imgOption3.frame.bottom + 5, width: imgOption4.intrinsicContentSize.width, height: imgOption4.intrinsicContentSize.height)
            lblOption4.frame = CGRect(x: 0, y: imgOption4.frame.top + imgOption4.frame.height/2, width: Screen.width, height: lblOption4.intrinsicContentSize.height)
        } else {
            imgOption4.frame = CGRect(x: 0, y: imgOption3.frame.bottom + 5, width: imgOption4.intrinsicContentSize.width, height: 0)
            lblOption4.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        }
        
        tfRabbitCode.frame = CGRect(x: Screen.width/2 - Screen.width * 0.7 / 2, y: imgOption4.frame.bottom + 40, width: Screen.width * 0.7, height: tfRabbitCode.intrinsicContentSize.height)
        btnSubmit.frame = CGRect(x: 0, y: tfRabbitCode.frame.bottom + 40, width: Screen.width, height: btnSubmit.intrinsicContentSize.height)
        
        scrollView.contentSize = CGSize(width: Screen.width, height: btnSubmit.frame.bottom + 20)
    }
    
    func onSubmit() {
        // TODO: Submit pressed
    }
}




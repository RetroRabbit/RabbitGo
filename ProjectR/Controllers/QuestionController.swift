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

class QuestionController: UITableViewController {
    /* Data */
    fileprivate var lastTapped = -1
    fileprivate let question: Question
    fileprivate let index: Int
    
    init(question: Question, index: Int) {
        self.question = question
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension QuestionController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.backgroundColor = Style.color.grey_dark
        
        tableView.register(QuestionHeaderCell.self, forCellReuseIdentifier: QuestionHeaderCell.reuseIdentifier)
        tableView.register(OptionCell.self, forCellReuseIdentifier: OptionCell.reuseIdentifier)
        tableView.register(SubmitCell.self, forCellReuseIdentifier: SubmitCell.reuseIdentifier)
        
        /* This hides the extra separators for empty rows. See http://stackoverflow.com/a/5377569/1469018 */
        tableView.tableFooterView = UIView()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let cell = QuestionHeaderCell()
            cell.prepareForDisplay(question: question, index: index)
            return cell
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return question.multiple?.count ?? 0
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: OptionCell.reuseIdentifier, for: indexPath as IndexPath) as? OptionCell {
                cell.prepareForDisplay(question: question, index: index)
                return cell
            } else {
                return UITableViewCell()
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SubmitCell.reuseIdentifier, for: indexPath as IndexPath) as? SubmitCell {
                return cell
            } else {
                return UITableViewCell()
            }
        default:
            return UITableViewCell()
        }
    }
}


/* Table header cell */
class QuestionHeaderCell: UITableViewCell {
    class var reuseIdentifier: String { return "questionCell" }
    
    /* UI */
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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Material.Color.white
        selectionStyle = .none
        
        addSubview(lblQuestionNumber)
        addSubview(lblQuestion)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    final func prepareForDisplay(question: Question, index: Int) {
        lblQuestionNumber.attributedText = NSAttributedString(string: "Question #\(index)", attributes: Style.avenirh_small_grey_dark_center)
        lblQuestion.attributedText = NSAttributedString(string: question.text as String? ?? "", attributes: Style.avenirh_extra_large_grey_dark_center)
        
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        lblQuestionNumber.frame = CGRect(x: 0, y: 15, width: Screen.width, height: lblQuestionNumber.intrinsicContentSize.height)
        lblQuestion.frame = CGRect(x: 0, y: lblQuestionNumber.frame.bottom + 15, width: Screen.width, height: lblQuestion.intrinsicContentSize.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lblQuestionNumber.attributedText = NSAttributedString(string: "", attributes: Style.avenirh_small_grey_dark_center)
        lblQuestion.attributedText = NSAttributedString(string: "", attributes: Style.avenirh_extra_large_grey_dark_center)
        
        /* Trigger mask redraw */
        setNeedsDisplay()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: size.width, height: height())
    }
    
    func height() -> CGFloat {
        return lblQuestion.frame.bottom + 15
    }
}




/* Option cell */
class OptionCell: UITableViewCell {
    class var reuseIdentifier: String { return "optionCell" }
    
    /* UI */
    fileprivate let imgOption: UIImageView
    fileprivate let imgCheckMark: UIImageView
    
    fileprivate let lblOption: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "", attributes: Style.avenirh_small_white)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        imgOption = UIImageView(image: UIImage(named: "answer_square_grey"))
        imgOption.contentMode = .scaleAspectFit
        imgOption.clipsToBounds = true
        
        imgCheckMark = UIImageView(image: UIImage(named: "checkmark"))
        imgCheckMark.contentMode = .scaleAspectFit
        imgCheckMark.clipsToBounds = true
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = Style.color.grey_dark
        selectionStyle = .none
        
        addSubview(imgOption)
        addSubview(imgCheckMark)
        addSubview(lblOption)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    final func prepareForDisplay(question: Question, index: Int) {
        lblOption.attributedText = NSAttributedString(string: question.multiple?[index] as String? ?? "", attributes: Style.avenirh_small_white)
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imgOption.frame = CGRect(x: 0, y: 0, width: imgOption.intrinsicContentSize.width, height: imgOption.intrinsicContentSize.height)
        imgCheckMark.frame = CGRect(x: 0, y: 0, width: imgCheckMark.intrinsicContentSize.width, height: imgCheckMark.intrinsicContentSize.height)
        lblOption.frame = CGRect(x: imgCheckMark.frame.right + 10, y: imgOption.frame.top + imgOption.frame.height/2 - lblOption.frame.height/2, width: Screen.width, height: lblOption.intrinsicContentSize.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        lblOption.attributedText = NSAttributedString(string: "", attributes: Style.avenirh_small_white)
        
        /* Trigger mask redraw */
        setNeedsDisplay()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: size.width, height: height())
    }
    
    func height() -> CGFloat {
        return imgOption.frame.height
    }
}


/* Submit cell */
class SubmitCell: UITableViewCell {
    class var reuseIdentifier: String { return "submitCell" }
    
    /* UI */
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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Material.Color.white
        selectionStyle = .none
        
        addSubview(tfRabbitCode)
        addSubview(btnSubmit)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    final func prepareForDisplay(question: Question, index: Int) {}
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        tfRabbitCode.frame = CGRect(x: Screen.width/2 - Screen.width * 0.7 / 2, y: 40, width: Screen.width * 0.7, height: tfRabbitCode.intrinsicContentSize.height)
        btnSubmit.frame = CGRect(x: 0, y: tfRabbitCode.frame.bottom + 40, width: Screen.width, height: btnSubmit.intrinsicContentSize.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tfRabbitCode.placeholderText = ""
        
        /* Trigger mask redraw */
        setNeedsDisplay()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: size.width, height: height())
    }
    
    func height() -> CGFloat {
        return btnSubmit.frame.bottom + 20
    }
}


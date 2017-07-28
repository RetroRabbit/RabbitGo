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
        
        //tableView.register(QuestionHeaderCell.self, forCellReuseIdentifier: QuestionHeaderCell.reuseIdentifier)
        tableView.register(OptionCell.self, forCellReuseIdentifier: OptionCell.reuseIdentifier)
        tableView.register(SubmitCell.self, forCellReuseIdentifier: SubmitCell.reuseIdentifier)
        
        /* This hides the extra separators for empty rows. See http://stackoverflow.com/a/5377569/1469018 */
        //tableView.tableFooterView = UIView()
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
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return QuestionHeaderCell.height(question: question, index: index)
        default:
            return 0.0
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
            let cell = tableView.dequeueReusableCell(withIdentifier: OptionCell.reuseIdentifier, for: indexPath as IndexPath) as! OptionCell
            cell.prepareForDisplay(question: question, index: indexPath.row)
            return cell
        case 1:
            return tableView.dequeueReusableCell(withIdentifier: SubmitCell.reuseIdentifier, for: indexPath as IndexPath) as! SubmitCell
        default:
            return UITableViewCell()
        }
    }
}


/* Table header cell */
class QuestionHeaderCell: UIView {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(lblQuestionNumber)
        addSubview(lblQuestion)
        backgroundColor = Material.Color.white
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
    
    static func height(question: Question, index: Int) -> CGFloat {
        return NSAttributedString(string: question.text as String? ?? "", attributes: Style.avenirh_extra_large_grey_dark_center).height(forWidth: Screen.width) + 15 +
                NSAttributedString(string: "Question #\(index)", attributes: Style.avenirh_small_grey_dark_center).height(forWidth: Screen.width) + 30
    }
}

/* Option cell */
class OptionCell: UITableViewCell {
    class var reuseIdentifier: String { return "optionCell" }
    
    /* UI */
    fileprivate let imgOption: UIImageView = UIImageView()/* {
        //let img = UIImageView(image: UIImage(named: "answer_square_grey"))
        //img.contentMode = .scaleAspectFit
        //img.clipsToBounds = true
        imgOption
        return img
    }()*/
    
    fileprivate let imgCheckMark: UIImageView = {
        let img = UIImageView(image: UIImage(named: "checkmark"))
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        return img
    }()
    
    fileprivate let lblOption: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "", attributes: Style.avenirh_small_white)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = Style.color.grey_dark
        imgOption.backgroundColor = Style.color.grey_light
        addSubview(imgOption)
        imgOption.addSubview(imgCheckMark)
        imgOption.addSubview(lblOption)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    final func prepareForDisplay(question: Question, index: Int) {
        lblOption.attributedText = NSAttributedString(string: question.multiple?[index] as String? ?? "", attributes: Style.avenirh_small_white)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //contentView.frame = CGRect(x: 0, y: 0, width: Screen.width, height: height())
        let height = max(lblOption.intrinsicContentSize.height,  imgCheckMark.intrinsicContentSize.height)
        let width = Screen.width - 20
        imgOption.frame =  CGRect(x: 10, y: 10, width: width, height: height + 20)
        
        //center checkmark to text
        if lblOption.intrinsicContentSize.height > imgCheckMark.intrinsicContentSize.height {
            lblOption.preferredMaxLayoutWidth = width - 28 - 20
            lblOption.frame = CGRect(x: 20 + 28 + 10, y: 10, width: width, height: lblOption.intrinsicContentSize.height)
            
            let y = (imgOption.height - imgCheckMark.intrinsicContentSize.height) / 2
            imgCheckMark.frame = CGRect(x: 10, y: y, width: imgCheckMark.intrinsicContentSize.width, height: imgCheckMark.intrinsicContentSize.height)
            
        } else {
            imgCheckMark.frame = CGRect(x: 10, y: 10, width: imgCheckMark.intrinsicContentSize.width, height: imgCheckMark.intrinsicContentSize.height)
            
            let y = (imgOption.height - lblOption.intrinsicContentSize.height) / 2
            lblOption.preferredMaxLayoutWidth = width - 28 - 20
            lblOption.frame = CGRect(x: 20 + 28 + 10, y: y, width: width, height: lblOption.intrinsicContentSize.height)
        }
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
        return max(lblOption.intrinsicContentSize.height,  imgCheckMark.intrinsicContentSize.height) + 40
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
        backgroundColor = Style.color.grey_dark
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
        
        tfRabbitCode.frame = CGRect(x: Style.input_center, y: 20, width: Style.input_width, height: 40)
        
        let submitX = (Screen.width - Style.button_width)/2
        btnSubmit.frame = CGRect(x: submitX, y: tfRabbitCode.frame.bottom + 20, width: Style.button_width, height: Style.button_height)
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
        return 40 + 20 +
        Style.button_height + 40
    }
}

extension NSAttributedString {
    func highlight(attributes: [String: Any]) -> NSAttributedString {
        let regex = try! NSRegularExpression(pattern:"\\*(.*?)\\*", options: [])
        let mutable = NSMutableAttributedString(attributedString: self)
        let numberMatches = regex.numberOfMatches(in: mutable.string, options: [], range: NSMakeRange(0, mutable.string.characters.count))
        for _ in 0 ..< numberMatches {
            let range0 = regex.rangeOfFirstMatch(in: mutable.string, options: [], range: NSMakeRange(0, mutable.string.characters.count))
            let range1 = NSRange(location: range0.location + 1, length: range0.length - 2)
            mutable.replaceCharacters(
                in: range0,
                with: NSAttributedString(
                    string: (mutable.string as NSString).substring(with: range1),
                    attributes: attributes))
        }
        return mutable as NSAttributedString
    }
    
    func height(forWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        return boundingBox.height
    }
    
    func width(forHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        return boundingBox.width
    }
}



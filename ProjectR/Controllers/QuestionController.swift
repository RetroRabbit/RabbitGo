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
import Firebase

protocol QuestionDelegate {
    func answeredQuestion(index: Int, selectedIndex: IndexPath)
}

class QuestionController: UITableViewController {
    /* Data */
    fileprivate var lastTapped: IndexPath?   // Which self.tableView cell was last tapped
    fileprivate let question: Question
    fileprivate let index: Int
    fileprivate let selectedIndex: IndexPath // Which parent collection cell brough you here
    fileprivate let questionDelegate: QuestionDelegate
    fileprivate var isMultipleChoice: Bool = true
    
    init(question: Question, index: Int, selectedIndex: IndexPath, delegate: QuestionDelegate) {
        self.question = question
        self.index = index
        self.selectedIndex = selectedIndex
        self.questionDelegate = delegate
        
        if question.multiple?[0] == "" {
            self.isMultipleChoice = false
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension QuestionController: SubmitDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.backgroundColor = Style.color.grey_dark
        
        //tableView.register(QuestionHeaderCell.self, forCellReuseIdentifier: QuestionHeaderCell.reuseIdentifier)
        tableView.register(OptionCell.self, forCellReuseIdentifier: OptionCell.reuseIdentifier)
        tableView.register(InputCell.self, forCellReuseIdentifier: InputCell.reuseIdentifier)
        tableView.register(SubmitCell.self, forCellReuseIdentifier: SubmitCell.reuseIdentifier)
        
        navigationItem.title = "Rabbit Go!"
        navigationItem.titleLabel.textAlignment = .left
        navigationItem.titleLabel.textColor = Style.color.white
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
            if isMultipleChoice {
                return question.multiple?.count ?? 0
            } else {
                return 1
            }
            
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if isMultipleChoice {
                let cell = tableView.dequeueReusableCell(withIdentifier: OptionCell.reuseIdentifier, for: indexPath as IndexPath) as! OptionCell
                cell.prepareForDisplay(question: question, index: indexPath.row)
                return cell
            } else {
                return tableView.dequeueReusableCell(withIdentifier: InputCell.reuseIdentifier, for: indexPath as IndexPath) as! InputCell
            }
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: SubmitCell.reuseIdentifier, for: indexPath as IndexPath) as! SubmitCell
            cell.delegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Remove previous check mark
        if indexPath.section == 0 {
            if let lastTapped = lastTapped {
                let cell = tableView.cellForRow(at: lastTapped) as! OptionCell
                cell.imgCheckMark.isHidden = true
            }
            
            // Set new check mark
            lastTapped = indexPath
            let cell = tableView.cellForRow(at: indexPath) as! OptionCell
            cell.imgCheckMark.isHidden = false
        }
    }
    
    /* Protocol submit */
    func onSubmit() {
        let tfCell = tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! SubmitCell
        let rabbitCode = tfCell.tfRabbitCode.text
        
        verifyRabbitCode(code: rabbitCode, completion: verifyAnswer)
    }
    
    func verifyRabbitCode(code: String?, completion: @escaping () -> ()) {
        if nil == firebaseRabbits.index(where: { rabbit -> Bool in return rabbit.code == code }) {
            // Invalid rabbit code
            let ac = UIAlertController(title: "Invalid Rabbit Code", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Try again", style: .default))
            self.present(ac, animated: true)
        }
        
        completion()
    }
    
    func verifyAnswer() {
        /* Multple choice */
        if !isMultipleChoice {
            let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! InputCell
            if cell.tfUserInput.text != "" {
                // TODO: Do something with user input??
                // Correct answer
                increaseScore()
                refCurrentUserQuestions().observeSingleEvent(of: .value, with: { [weak self] (dataSnapShot) in
                    guard let this = self else { return }
                    let answeredQuestion = dataSnapShot.childSnapshot(forPath: this.question.qrCode ?? "")
                    answeredQuestion.childSnapshot(forPath: "state").ref.setValue(2)
                    
                    let ac = UIAlertController(title: "You unlocked Rabbit #\(this.index)", message: nil, preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "View", style: .default, handler: { _ in
                        this.navigationController?.popViewController(animated: true)
                        this.questionDelegate.answeredQuestion(index: this.index, selectedIndex: this.selectedIndex)
                    }))
                    this.present(ac, animated: true)
                })
                return
            }
        }
        
        /* Check for selected answer */
        guard let lastTapped = lastTapped else {
            // No answer selected
            let ac = isMultipleChoice
                        ? UIAlertController(title: "Please pick an answer", message: nil, preferredStyle: .alert)
                        : UIAlertController(title: "Please enter an answer", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Dismiss", style: .default))
            present(ac, animated: true)
            return
        }
        
        if lastTapped.row + 1 == Int(question.answer ?? 0) {
            // Correct answer
            increaseScore()
            refCurrentUserQuestions().observeSingleEvent(of: .value, with: { [weak self] (dataSnapShot) in
                guard let this = self else { return }
                let answeredQuestion = dataSnapShot.childSnapshot(forPath: this.question.qrCode ?? "")
                answeredQuestion.childSnapshot(forPath: "state").ref.setValue(2)

                let ac = UIAlertController(title: "You unlocked Rabbit #\(this.index)", message: nil, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "View", style: .default, handler: { _ in
                    this.navigationController?.popViewController(animated: true)
                    this.questionDelegate.answeredQuestion(index: this.index, selectedIndex: this.selectedIndex)
                }))
                this.present(ac, animated: true)
            })
        } else {
            // Incorrect answer
            let ac = UIAlertController(title: "Wrong answer!", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ask another Rabbit", style: .default))
            present(ac, animated: true)
        }
    }
    
    func increaseScore() {
        refCurrentUser().observeSingleEvent(of: .value, with: { (snapshot) in
            var currentScore = snapshot.childSnapshot(forPath: "score").value as? Int ?? 0
            currentScore += 1
            snapshot.childSnapshot(forPath: "score").ref.setValue(currentScore, withCompletionBlock: { (error, ref) in
                if let error = error {
                    NSLog("❌ Unable to increment score - \(error.localizedDescription)")
                }
            })

        })
    }

}

protocol SubmitDelegate: class {
    func onSubmit()
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
        label.attributedText = NSAttributedString(string: "", attributes: Style.avenirh_large_grey_dark_center)
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
        lblQuestion.attributedText = NSAttributedString(string: question.text as String? ?? "", attributes: Style.avenirh_large_grey_dark_center)
        
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        lblQuestionNumber.frame = CGRect(x: 0, y: 15, width: Screen.width, height: lblQuestionNumber.intrinsicContentSize.height)
        lblQuestion.frame = CGRect(x: 0, y: lblQuestionNumber.frame.bottom + 15, width: Screen.width, height: lblQuestion.intrinsicContentSize.height)
    }
    
    static func height(question: Question, index: Int) -> CGFloat {
        return NSAttributedString(string: question.text as String? ?? "", attributes: Style.avenirh_large_grey_dark_center).height(forWidth: Screen.width) + 15 +
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
        img.isHidden = true
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
        let optionWidth = width - 28 - 40
        lblOption.preferredMaxLayoutWidth = width - 28 - 40
        
        //center checkmark to text
        if lblOption.intrinsicContentSize.height > imgCheckMark.intrinsicContentSize.height {
            let optionY = ((height + 20) - lblOption.intrinsicContentSize.height) / 2
            lblOption.frame = CGRect(x: 10 + 28 + 10, y: optionY, width: optionWidth, height: lblOption.intrinsicContentSize.height)
            
            let y = (imgOption.height - imgCheckMark.intrinsicContentSize.height) / 2
            imgCheckMark.frame = CGRect(x: 10, y: y, width: imgCheckMark.intrinsicContentSize.width, height: imgCheckMark.intrinsicContentSize.height)
            
        } else {
            let markY = ((height + 20) - imgCheckMark.intrinsicContentSize.height) / 2
            imgCheckMark.frame = CGRect(x: 10, y: markY, width: imgCheckMark.intrinsicContentSize.width, height: imgCheckMark.intrinsicContentSize.height)
            
            let y = (imgOption.height - lblOption.intrinsicContentSize.height) / 2
            lblOption.frame = CGRect(x: 10 + 28 + 10, y: y, width: optionWidth, height: lblOption.intrinsicContentSize.height)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        lblOption.attributedText = NSAttributedString(string: "", attributes: Style.avenirh_small_white)
        
        /* Trigger mask redraw */
        setNeedsDisplay()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: size.width, height: calculateheight())
    }
    
    func calculateheight() -> CGFloat {
        return max(lblOption.intrinsicContentSize.height,  imgCheckMark.intrinsicContentSize.height) + 40
    }
}

/* Input cell */
class InputCell: UITableViewCell {
    class var reuseIdentifier: String { return "inputCell" }
    
    /* UI */
    let tfUserInput: ProjectRTextField = {
        let textField = ProjectRTextField()
        textField.placeholder = "Enter answer"
        textField.autocapitalizationType = .none
        return textField
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Style.color.grey_dark
        selectionStyle = .none
        
        addSubview(tfUserInput)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        tfUserInput.frame = CGRect(x: Style.input_center, y: 20, width: Style.input_width, height: 40)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tfUserInput.placeholderText = "Enter answer"
        
        /* Trigger mask redraw */
        setNeedsDisplay()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: size.width, height: height())
    }
    
    func height() -> CGFloat {
        return Style.button_height + 40
    }
}


/* Submit cell */
class SubmitCell: UITableViewCell {
    class var reuseIdentifier: String { return "submitCell" }
    
    /* Data */
    weak var delegate: SubmitDelegate?
    
    /* UI */
    let tfRabbitCode: ProjectRTextField = {
        let textField = ProjectRTextField()
        textField.placeholder = "Unique Rabbit Code"
        textField.autocapitalizationType = .none
        return textField
    }()
    
    lazy var btnSubmit :ProjectRButton = {
        let btn = ProjectRButton()
        btn.setTitle("SUBMIT", for: .normal)
        btn.addTarget(self, action: #selector(onSubmit), for: UIControlEvents.touchUpInside)
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
        btnSubmit.frame = CGRect(x: submitX, y: tfRabbitCode.frame.bottom + 40, width: Style.button_width, height: Style.button_height)
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
        return 40 + 40 +
        Style.button_height + 40
    }
    
    func onSubmit() {
        delegate?.onSubmit()
    }
    
}

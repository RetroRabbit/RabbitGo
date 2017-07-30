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
import RxSwift

class QuestionController: UITableViewController {
    /* Data */
    fileprivate var lastTapped: IndexPath?   // Which self.tableView cell was last tapped
    fileprivate let question: Question
    fileprivate let index: Int
    fileprivate var isMultipleChoice: Bool = true
    fileprivate var lockedCodes: [String] = []
    
    init(question: Question, index: Int, lockedCodes: [String]) {
        self.question = question
        self.index = index
        self.lockedCodes = lockedCodes
        
        if question.multiple?[0] == "" {
            self.isMultipleChoice = false
        }
        
        super.init(nibName: nil, bundle: nil)
        
        self.hidesBottomBarWhenPushed = true
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
                cell.imgOption.backgroundColor = Style.color.grey_light
            }
            
            // Set new check mark
            lastTapped = indexPath
            let cell = tableView.cellForRow(at: indexPath) as! OptionCell
            cell.imgCheckMark.isHidden = false
            cell.lblOption.attributedText = NSAttributedString(string: cell.lblOption.attributedText?.string ?? "", attributes: Style.avenirh_small_grey_dark)
            cell.imgOption.backgroundColor = Style.color.green
        }
    }
    
    /* Protocol submit - this is sssoooo badly written thanx!*/
    func onSubmit() {
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
        
        let tfCell = tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! SubmitCell
        let rabbitCode = tfCell.tfRabbitCode.text?.trimmed ?? ""
        
        //first check rabbit code
        if nil == firebaseRabbits.index(where: { rabbit -> Bool in return rabbit.code == rabbitCode }) || lockedCodes.contains(rabbitCode) {
            // Invalid rabbit code
            let ac = UIAlertController(title: rabbitCode.isEmpty ? "Please provide a rabbit code" : "Invalid Rabbit Code", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Try again", style: .default))
            self.present(ac, animated: true)
            return
        }
        
        //check question correct
        if lastTapped.row + 1 != Int(question.answer ?? 0) && !lockedCodes.contains(rabbitCode) {
            lockedCodes.append(rabbitCode)
            _ = updateUserFields(rabbitCode: rabbitCode, playerQuestion: PlayerQuestion(state: QuestionState.unlocked.rawValue, lockedCodes: lockedCodes.unique()))
                .subscribe( onCompleted: { [weak self] in
                    // Incorrect answer
                    let ac = UIAlertController(title: "Wrong answer!", message: nil, preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "Ask another Rabbit", style: .default))
                    self?.present(ac, animated: true)
                })
            
            return
        }
        
        var player: PlayerQuestion!
        
        /* Multple choice */
        if !isMultipleChoice,
            let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? InputCell,
            !(cell.tfUserInput.text?.isEmpty ?? true){
            // Correct answer
            player = PlayerQuestion(state: QuestionState.done.rawValue)
        } else {
            // Correct answer selection
            player = PlayerQuestion(state: QuestionState.done.rawValue)
        }
        
        _ = updateUserFields(rabbitCode: rabbitCode, playerQuestion: player).subscribe(onCompleted: { [weak self] in
            guard let this = self else { return }
            
            let ac = UIAlertController(title: "You unlocked Rabbit #\(this.index)", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "View", style: .default, handler: { _ in
                this.navigationController?.popViewController(animated: true)
            }))
            this.present(ac, animated: true)
        })
    }
    
    func updateUserFields(rabbitCode: String, playerQuestion: PlayerQuestion) -> Observable<()> {
        return Observable.create { [weak self] observable in
            guard let this = self else { return Disposables.create() }
            _ = Observable
                .from([
                    this.updateCurrentUserQuestions(playerQuestion: playerQuestion),
                    this.updateScore(playerQuestion: playerQuestion),
                    this.updateRabbitScore(rabbitCode: rabbitCode, playerQuestion: playerQuestion),
                    this.updateRabbitTeamScore(rabbitCode: rabbitCode, playerQuestion: playerQuestion)
                    ])
                .merge()
                .subscribe(onCompleted: {
                    observable.onCompleted()
                })
            
            return Disposables.create()
        }
    }
    
    func updateCurrentUserQuestions(playerQuestion: PlayerQuestion) -> Observable<()> {
        return Observable.create { [weak self] observable in
            guard let this = self else { return Disposables.create()}
            refCurrentUserQuestions().child(this.question.qrCode ?? "").setValue(playerQuestion.formatted(), withCompletionBlock: { (err, ref) in
                observable.onCompleted()
            })
            
            return Disposables.create()
        }
    }
    
    func updateRabbitScore(rabbitCode: String, playerQuestion: PlayerQuestion) -> Observable<()> {
        return Observable.create { [weak self] observable in
            guard let this = self else { return Disposables.create()}
            refRabbitBoard(rabbitCode: rabbitCode).observeSingleEvent(of:.value, with: { dataSnap in
                var values: [String: Any] = [:]
                if let array = dataSnap.children.allObjects as? [DataSnapshot] {
                    array.forEach({ snap in
                        values[snap.key] = snap.value as? Bool ?? true
                    })
                }
                values["\(currentUserId())_\(this.question.qrCode ?? "")"] = playerQuestion.state == QuestionState.done.rawValue ? true : false
                refRabbitBoard(rabbitCode: rabbitCode).setValue(values, withCompletionBlock: { (err, ref) in
                    observable.onCompleted()
                })
            })
            
            return Disposables.create()
        }
    }
    
    func updateRabbitTeamScore(rabbitCode: String, playerQuestion: PlayerQuestion) -> Observable<()> {
        return Observable.create { [weak self] observable in
            guard let this = self else { return Disposables.create()}
            if let team = firebaseRabbits.first(where: { rabbit -> Bool in return rabbit.code == rabbitCode })?.team {
                refRabbitTeamBoard(team: team).observeSingleEvent(of: .value, with: { dataSnap in
                    var values: [String: Any] = [:]
                    if let array = dataSnap.children.allObjects as? [DataSnapshot] {
                        array.forEach({ snap in
                            values[snap.key] = snap.value as? Bool ?? true
                        })
                    }
                    values["\(currentUserId())_\(this.question.qrCode ?? "")"] = playerQuestion.state == QuestionState.done.rawValue ? true : false
                    refRabbitTeamBoard(team: team).setValue(values, withCompletionBlock: { (err, ref) in
                        observable.onCompleted()
                    })
                })
            }
            
            return Disposables.create()
        }
    }
    
    func updateScore(playerQuestion: PlayerQuestion) -> Observable<()>  {
        return Observable.create { observable in
            if playerQuestion.state == 2 {
                refCurrentUser().observeSingleEvent(of: .value, with: { (snapshot) in
                    var currentScore = snapshot.childSnapshot(forPath: "score").value as? Int ?? 0
                    currentScore += 1
                    snapshot.childSnapshot(forPath: "score").ref.setValue(currentScore, withCompletionBlock: { (error, ref) in
                        if currentScore == 21 {
                            refRabbiteers.queryOrdered(byChild: SCORE).queryStarting(atValue: 21).observeSingleEvent(of: .value, with: { rabbiteers in
                                if rabbiteers.hasChildren() {
                                    switch rabbiteers.childrenCount {
                                    case 1 where (rabbiteers.children.allObjects[0] as? DataSnapshot)?.key == currentUserId():
                                        refCurrentUser().child("score").setValue(FIRST_PLACE, withCompletionBlock: { _ in
                                            let ac = UIAlertController(title: "CONGRATULATIONS!", message: "You are 2017 \n Rabbit Go Winner!", preferredStyle: .alert)
                                            ac.addAction(UIAlertAction(title: "HOORAH!", style: .default, handler: { _ in
                                                observable.onCompleted()
                                            }))
                                            
                                            DispatchQueue.main.async {
                                                self.present(ac, animated: true)
                                            }
                                        })
                                        break
                                    case 2 where (rabbiteers.children.allObjects[0] as? DataSnapshot)?.key == currentUserId():
                                        refCurrentUser().child("score").setValue(SECOND_PLACE, withCompletionBlock: { _ in
                                            let ac = UIAlertController(title: "CONGRATULATIONS!", message: "You have taken 2nd place!", preferredStyle: .alert)
                                            ac.addAction(UIAlertAction(title: "HOORAH!", style: .default, handler: { _ in
                                                observable.onCompleted()
                                            }))
                                            
                                            DispatchQueue.main.async {
                                                self.present(ac, animated: true)
                                            }
                                        })
                                        break
                                    case 3 where (rabbiteers.children.allObjects[0] as? DataSnapshot)?.key == currentUserId():
                                        refCurrentUser().child("score").setValue(THIRD_PLACE, withCompletionBlock: { _ in
                                            let ac = UIAlertController(title: "CONGRATULATIONS!", message: "You have taken 3rd place!", preferredStyle: .alert)
                                            ac.addAction(UIAlertAction(title: "HOORAH!", style: .default, handler: { _ in
                                                observable.onCompleted()
                                            }))
                                            
                                            DispatchQueue.main.async {
                                                self.present(ac, animated: true)
                                            }
                                        })
                                        break
                                    default:
                                        refCurrentUser().child("score").setValue(FIRST_PLACE - Int(rabbiteers.childrenCount), withCompletionBlock: { _ in
                                            //just hang in there
                                        })
                                        break
                                        
                                    }
                                }
                            })
                        } else {
                            observable.onCompleted()
                        }
                    })
                    
                })
            } else {
                observable.onCompleted()
            }
            return Disposables.create()
        }
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
    
    fileprivate var optionHeight: CGFloat = 0
    
    /* UI */
    fileprivate let imgOption: UIImageView = UIImageView()
    
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
        let width = Screen.width - 20
        let optionWidth = width - 28 - 40
        optionHeight = NSAttributedString(string: question.multiple?[index] as String? ?? "", attributes: Style.avenirh_small_white).height(forWidth: optionWidth)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //contentView.frame = CGRect(x: 0, y: 0, width: Screen.width, height: height())
        let height = max(optionHeight, 28)
        let width = Screen.width - 20
        imgOption.frame =  CGRect(x: 10, y: 10, width: width, height: height + 20)
        let optionWidth = width - 28 - 40
        lblOption.preferredMaxLayoutWidth = width - 28 - 40
        
        //center checkmark to text
        if lblOption.intrinsicContentSize.height > imgCheckMark.intrinsicContentSize.height {
            let optionY = ((height + 20) - optionHeight) / 2
            lblOption.frame = CGRect(x: 10 + 28 + 10, y: optionY, width: optionWidth, height: lblOption.intrinsicContentSize.height)
            
            let y = (imgOption.height - imgCheckMark.intrinsicContentSize.height) / 2
            imgCheckMark.frame = CGRect(x: 10, y: y, width: imgCheckMark.intrinsicContentSize.width, height: imgCheckMark.intrinsicContentSize.height)
            
        } else {
            let markY = ((height + 20) - imgCheckMark.intrinsicContentSize.height) / 2
            imgCheckMark.frame = CGRect(x: 10, y: markY, width: imgCheckMark.intrinsicContentSize.width, height: imgCheckMark.intrinsicContentSize.height)
            
            let y = (imgOption.height - optionHeight) / 2
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
        return max(optionHeight, 28) + 40
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

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var alreadyAdded = Set<Iterator.Element>()
        return self.filter { alreadyAdded.insert($0).inserted }
    }
}

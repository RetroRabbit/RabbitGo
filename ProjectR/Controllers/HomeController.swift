//
//  homeController.swift
//  ProjectR
//
//  Created by Henko on 2017/07/09.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import Foundation
import UIKit
import Material

struct Leader {
    var position: Int = 0
    var fullname: String = ""
    var questionsAnswered: Int = 0
    
    init(position: Int, fullname: String, questionsAnswered: Int) {
        self.position = position
        self.fullname = fullname
        self.questionsAnswered = questionsAnswered
    }
}

struct Position {
    var fullname: String = "Niell Agendag ;)"
    var questionsUnanswered: Int = 10
    var questions: Int = 20
    var position: Int64 = 43
    
    /*init(fullname: String, questionsUnanswered: Int, questions: Int, position: Int64) {
        self.fullname = fullname
        self.questionsUnanswered = questionsUnanswered
        self.questions = questions
        self.position = position
    }*/
}

class HomeController : UITableViewController {
    static let instance = HomeController()
    
    fileprivate let userObject: Position = Position()
    
    fileprivate let leaders: [Leader] = [
        Leader(position: 1, fullname: "Todd Caldwell", questionsAnswered: 15),
        Leader(position: 2, fullname: "Todd Caldwell", questionsAnswered: 13),
        Leader(position: 3, fullname: "Todd Caldwell", questionsAnswered: 12),
        Leader(position: 4, fullname: "Todd Caldwell", questionsAnswered: 12),
        Leader(position: 5, fullname: "Todd Caldwell", questionsAnswered: 10),
        Leader(position: 6, fullname: "Todd Caldwell", questionsAnswered: 8),
        Leader(position: 7, fullname: "Todd Caldwell", questionsAnswered: 7),
        Leader(position: 8, fullname: "Todd Caldwell", questionsAnswered: 6),
        Leader(position: 9, fullname: "Todd Caldwell", questionsAnswered: 2)
    ]
    
    init() {
        super.init(nibName: nil, bundle: nil)

        //super.init(hiding: NavigationHide.toBottom)
        navigationController?.title = "Leaderboard Position #43"
        tabBarItem.title = "Home"
        tabBarItem.image = UIImage(named: "home")
        tableView.allowsMultipleSelectionDuringEditing = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.register(HeaderCell.self, forCellReuseIdentifier: HeaderCell.reuseIdentifier)
        tableView.register(LeaderBoardCell.self, forCellReuseIdentifier: LeaderBoardCell.reuseIdentifier)
        
        /* This hides the extra separators for empty rows. See http://stackoverflow.com/a/5377569/1469018 */
        tableView.tableFooterView = UIView()
        
        navigationItem.title = "Leaderboard Position #43"
        navigationItem.titleLabel.textAlignment = .center
        navigationItem.titleLabel.textColor = Material.Color.blueGrey.lighten3
    }
}

extension HomeController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return leaders.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: HeaderCell.reuseIdentifier) as! HeaderCell
            cell.prepareForDisplay(object: userObject)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: LeaderBoardCell.reuseIdentifier) as! LeaderBoardCell
            cell.prepareForDisplay(object: leaders[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }
}



class HeaderCell: UITableViewCell {
    class var reuseIdentifier: String { return "HeaderCell" }
    
    private let lblHeading: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let vwPositionBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.retroGrey
        return view
    }()
    
    private let lblQuestionsHeader: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.attributedText = NSAttributedString(string: "QUESTIONS ANSWERED", attributes: Style.body_white_center)
        return label
    }()
    
    private let vwSeperator: UIView = {
        let view = UIView()
        view.backgroundColor = Color.white
        return view
    }()
    
    private let lblQuestionsUnanswered: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let vwDivider: UIView = {
        let view = UIView()
        view.backgroundColor = Color.white
        return view
    }()
    
    private let lblQuestions: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.attributedText = NSAttributedString(string: "20", attributes: Style.body_white_center)
        return label
    }()
    
    private let lblPositionHeader: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.attributedText = NSAttributedString(string: "LEADERBOARD POSITION", attributes: Style.body_white_center)
        return label
    }()
    
    private let lblPosition: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let lblLeadboardHeader: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.attributedText = NSAttributedString(string: "LEADERBOARD RANKING", attributes: Style.body_center)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(lblHeading)
        contentView.addSubview(vwPositionBackground)
        vwPositionBackground.addSubview(vwSeperator)
        
        vwPositionBackground.addSubview(lblQuestionsHeader)
        vwPositionBackground.addSubview(lblPositionHeader)
        
        vwPositionBackground.addSubview(lblQuestionsUnanswered)
        vwPositionBackground.addSubview(vwDivider)
        vwPositionBackground.addSubview(lblQuestions)
        
        vwPositionBackground.addSubview(lblPosition)
        
        contentView.addSubview(lblLeadboardHeader)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareForDisplay(object: Position) {
        lblHeading.attributedText = NSAttributedString(string: "Welcome \(object.fullname)", attributes: Style.heading_2a)
        lblQuestionsUnanswered.attributedText = NSAttributedString(string: "\(object.questionsUnanswered)", attributes: Style.body_white_center)
        lblPosition.attributedText = NSAttributedString(string: "\(object.position)", attributes: Style.body_white_center)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        lblHeading.frame = CGRect(x: (Screen.width - lblHeading.intrinsicContentSize.width)/2, y:  Style.padding.l, width: lblHeading.intrinsicContentSize.width, height: lblHeading.intrinsicContentSize.height)
        
        let width = (Screen.width - 40)
        vwPositionBackground.frame = CGRect(x:  Style.padding.l, y: lblHeading.frame.bottom +  Style.padding.l, width: width, height: 200)
        vwSeperator.autoSetDimensions(to: CGSize(width: 2, height: 160))
        vwSeperator.autoAlignAxis(toSuperviewAxis: .vertical)
        vwSeperator.autoPinEdge(toSuperviewEdge: .top, withInset:  Style.padding.l)
        
        lblQuestionsHeader.autoPinEdge(toSuperviewEdge: .top, withInset:  Style.padding.l)
        lblQuestionsHeader.autoPinEdge(toSuperviewEdge: .left)
        lblQuestionsHeader.autoPinEdge(.right, to: .left, of: vwSeperator)
        
        lblPositionHeader.autoPinEdge(toSuperviewEdge: .top, withInset:  Style.padding.l)
        lblPositionHeader.autoPinEdge(.left, to: .right, of: vwSeperator)
        lblPositionHeader.autoPinEdge(toSuperviewEdge: .right)
        
        lblQuestionsUnanswered.autoPinEdge(.top, to: .bottom, of: lblQuestionsHeader, withOffset:  Style.padding.l)
        lblQuestionsUnanswered.autoPinEdge(.left, to: .left, of: lblQuestionsHeader)
        
        lblQuestions.autoPinEdge(.top, to: .bottom, of: lblQuestionsUnanswered, withOffset: 60)
        lblQuestions.autoPinEdge(.right, to: .right, of: lblQuestionsHeader)
        
        vwDivider.autoPinEdge(.top, to: .bottom, of: lblQuestionsUnanswered, withOffset: 2)
        vwDivider.autoSetDimension(.height, toSize: 2)
        vwDivider.autoPinEdge(.left, to: .right, of: lblQuestionsUnanswered)
        vwDivider.autoPinEdge(.right, to: .left, of: lblQuestions)
        
        lblPosition.autoAlignAxis(.vertical, toSameAxisOf: lblPositionHeader)
        lblPosition.autoPinEdge(.top, to: .bottom, of: lblPositionHeader, withOffset:  Style.padding.l)
        
        lblLeadboardHeader.frame = CGRect(x: (Screen.width - lblLeadboardHeader.intrinsicContentSize.width)/2, y: vwPositionBackground.frame.bottom +  Style.padding.l, width: lblLeadboardHeader.intrinsicContentSize.width, height: lblLeadboardHeader.intrinsicContentSize.height)
        
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: size.width, height: height())
    }
    
    func height() -> CGFloat {
        return 300
    }
}

class LeaderBoardCell: UITableViewCell {
    /* State */
    class var reuseIdentifier: String { return "LeaderBoardCell" }
    
    /* UI */
    let lblPosition: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.backgroundColor = Color.white
        return label
    }()
    
    let lblFullname: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let lblQuestionsAnswered: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = Color.green
        contentView.addSubview(lblPosition)
        contentView.addSubview(lblFullname)
        contentView.addSubview(lblQuestionsAnswered)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareForDisplay(object: Leader) {
        lblPosition.attributedText = NSAttributedString(string: "\(object.position)", attributes: Style.body_center)
        lblFullname.attributedText = NSAttributedString(string: object.fullname, attributes: Style.body_center)
        lblQuestionsAnswered.attributedText = NSAttributedString(string: "\(object.questionsAnswered)", attributes: Style.body_center)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let height = max(max(lblPosition.intrinsicContentSize.height, lblFullname.intrinsicContentSize.height), lblQuestionsAnswered.intrinsicContentSize.height) +  Style.padding.l
        
        contentView.frame = CGRect(x: Style.padding.s, y: Style.padding.s, width: Screen.width -  Style.padding.l, height: height)
        
        lblPosition.frame = CGRect(x: contentView.frame.left + Style.padding.s, y: (height - lblPosition.intrinsicContentSize.height)/2, width: lblPosition.intrinsicContentSize.width, height: lblPosition.intrinsicContentSize.height)
        
        lblFullname.frame = CGRect(x: lblPosition.frame.left + Style.padding.s, y: (height - lblFullname.intrinsicContentSize.height)/2, width: lblFullname.intrinsicContentSize.width, height: lblFullname.intrinsicContentSize.height)
        
        lblQuestionsAnswered.frame = CGRect(x: Screen.width - Style.padding.xxl - lblQuestionsAnswered.intrinsicContentSize.width, y: (height - lblQuestionsAnswered.intrinsicContentSize.height)/2, width: lblQuestionsAnswered.intrinsicContentSize.width, height: lblQuestionsAnswered.intrinsicContentSize.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lblPosition.attributedText = nil
        lblQuestionsAnswered.attributedText = nil
        lblFullname.attributedText = nil
        
        /* Trigger mask redraw */
        setNeedsDisplay()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: size.width, height: height())
    }
    
    func height() -> CGFloat {
        return max(max(lblPosition.intrinsicContentSize.height, lblFullname.intrinsicContentSize.height), lblQuestionsAnswered.intrinsicContentSize.height) + Style.padding.l + Style.padding.l
    }
}

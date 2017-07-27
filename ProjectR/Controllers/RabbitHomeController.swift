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
import Icomoon

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
    var fullname: String = "Niell"
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

class RabbitHomeController : UITableNavigationController {
    static let instance = RabbitHomeController()
    
    var currentSelection: Selection = Selection.individual
    
    fileprivate let userObject: Position = Position()
    
    fileprivate let leaders: [Leader] = [
        Leader(position: 1, fullname: "Todd", questionsAnswered: 15),
        Leader(position: 2, fullname: "Todd", questionsAnswered: 13),
        Leader(position: 3, fullname: "Todd", questionsAnswered: 12),
        Leader(position: 4, fullname: "Todd", questionsAnswered: 12),
        Leader(position: 5, fullname: "Todd", questionsAnswered: 10),
        Leader(position: 6, fullname: "Todd", questionsAnswered: 8),
        Leader(position: 7, fullname: "Todd", questionsAnswered: 7),
        Leader(position: 8, fullname: "Todd", questionsAnswered: 6),
        Leader(position: 9, fullname: "Todd", questionsAnswered: 2)
    ]
    
    fileprivate let teams: [Leader] = [
        Leader(position: 1, fullname: "Team 1", questionsAnswered: 15),
        Leader(position: 2, fullname: "Team 2", questionsAnswered: 13),
        Leader(position: 3, fullname: "Team 2", questionsAnswered: 12),
        Leader(position: 4, fullname: "Team 3", questionsAnswered: 12),
        Leader(position: 5, fullname: "Team 4", questionsAnswered: 10),
        Leader(position: 6, fullname: "Team 5", questionsAnswered: 8),
        Leader(position: 7, fullname: "Team 6", questionsAnswered: 7),
        Leader(position: 8, fullname: "Team 7", questionsAnswered: 6),
        Leader(position: 9, fullname: "Team 8", questionsAnswered: 2)
    ]
    
    init() {
        super.init(hiding: NavigationHide.toBottom)
        
        view.backgroundColor = Style.color.grey_dark
        
        tabBarItem.setTitleTextAttributes(Style.avenirh_xsmall_white_center, for: .normal)
        tabBarItem.title = "Home"
        tabBarItem.image = UIImage.iconWithName(Icomoon.Icon.Home, textColor: Material.Color.white, fontSize: 20).withRenderingMode(.alwaysOriginal)
        tabBarItem.selectedImage = UIImage.iconWithName(Icomoon.Icon.Home, textColor: Style.color.green, fontSize: 20).withRenderingMode(.alwaysOriginal)
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
        tableView.register(RabbitHeaderCell.self, forCellReuseIdentifier: RabbitHeaderCell.reuseIdentifier)
        tableView.register(RabbitLeaderBoardCell.self, forCellReuseIdentifier: RabbitLeaderBoardCell.reuseIdentifier)
        tableView.alwaysBounceVertical = false
        
        /* This hides the extra separators for empty rows. See http://stackoverflow.com/a/5377569/1469018 */
        tableView.tableFooterView = UIView()
    }
    
    override func prepareToolbar() {
        setTitle("Leaderboard Position #43", subtitle: nil)
    }
}

extension RabbitHomeController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1:
            return RabbitHeaderView.height()
        default:
            return 0.0
        }
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 1:
            let view = RabbitHeaderView()
            view.delegate = self
            return view
        default:
            return nil
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            if currentSelection == .individual {
                return leaders.count
            } else {
                return teams.count
            }
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: RabbitHeaderCell.reuseIdentifier) as! RabbitHeaderCell
            cell.prepareForDisplay(object: userObject)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: RabbitLeaderBoardCell.reuseIdentifier) as! RabbitLeaderBoardCell
            cell.prepareForDisplay(object: currentSelection == .individual ? leaders[indexPath.row] : teams[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension RabbitHomeController: RabbitHeaderCellDelegate {
    func onSelectionChange(selection: Selection) {
        self.currentSelection = selection
        var deletes: [IndexPath] = []
        var inserts: [IndexPath] = []
        for i in 0...(leaders.count - 1) {
            if currentSelection == .individual {
                inserts.append(IndexPath(row: i, section: 1))
            } else {
                deletes.append(IndexPath(row: i, section: 1))
            }
        }
        for i in 0...(teams.count - 1) {
            if currentSelection == .individual {
                deletes.append(IndexPath(row: i, section: 1))
            } else {
                inserts.append(IndexPath(row: i, section: 1))
            }
        }
        
        let lastScrollOffset = tableView.contentOffset
        
        tableView.beginUpdates()
        tableView.insertRows(at: inserts, with: .none)
        tableView.deleteRows(at: deletes, with: .none)
        tableView.endUpdates()

        tableView.layer.removeAllAnimations()
        tableView.setContentOffset(lastScrollOffset, animated: false)
    }
}

class RabbitHeaderView: UIView {
    
    weak var delegate: RabbitHeaderCellDelegate?
    
    fileprivate let lblIndividual: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.attributedText = NSAttributedString(string: "INDIVIDUAL", attributes: Style.avenirh_medium_grey_dark_center)
        label.layer.borderColor = Style.color.green.cgColor
        label.layer.borderWidth = 4.0
        label.backgroundColor = Style.color.green
        return label
    }()
    
    fileprivate let lblTeam: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.attributedText = NSAttributedString(string: "TEAM", attributes: Style.avenirh_medium_white_center)
        label.layer.borderColor = Style.color.green.cgColor
        label.layer.borderWidth = 4.0
        label.backgroundColor = Style.color.grey_dark
        return label
    }()
    
    private let lblRabbitsRanking: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.attributedText = NSAttributedString(string: "Rabbits Ranking", attributes: Style.avenirh_large_white)
        return label
    }()
    
    private let lblRank: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.attributedText = NSAttributedString(string: "#", attributes: Style.avenirl_extra_small_white_center)
        return label
    }()
    
    fileprivate let lblRankTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.attributedText = NSAttributedString(string: "RABBIT", attributes: Style.avenirl_extra_small_white)
        return label
    }()
    
    private let lblLeaderQuestionsAnswered: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.attributedText = NSAttributedString(string: "QUESTIONS ANSWERED", attributes: Style.avenirl_extra_small_white_right)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: Screen.width, height: RabbitHeaderView.height()))
        backgroundColor = Style.color.grey_dark
        
        addSubview(lblIndividual)
        addSubview(lblTeam)
        
        lblIndividual.isUserInteractionEnabled = true
        lblTeam.isUserInteractionEnabled = true
        
        lblIndividual.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectionChange)))
        lblTeam.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectionChange)))
        
        addSubview(lblRabbitsRanking)
        
        addSubview(lblRank)
        addSubview(lblRankTitle)
        addSubview(lblLeaderQuestionsAnswered)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = (Screen.width - 20) / 2
        
        lblIndividual.autoSetDimensions(to: CGSize(width: width, height: 40))
        lblIndividual.autoPinEdge(toSuperviewEdge: .top, withInset: 5)
        lblIndividual.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
        
        lblTeam.autoSetDimensions(to: CGSize(width: width, height: 40))
        lblTeam.autoPinEdge(toSuperviewEdge: .top, withInset: 5)
        lblTeam.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
        
        lblRabbitsRanking.autoPinEdge(.top, to: .bottom, of: lblIndividual, withOffset: 20)
        lblRabbitsRanking.autoPinEdge(.left, to: .left, of: lblIndividual)
        
        lblRank.autoSetDimension(.width, toSize: 40)
        lblRank.autoPinEdge(.top, to: .bottom, of: lblRabbitsRanking, withOffset: 10)
        lblRank.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
        
        lblRankTitle.autoSetDimension(.width, toSize: 100)
        lblRankTitle.autoPinEdge(.top, to: .bottom, of: lblRabbitsRanking, withOffset: 10)
        lblRankTitle.autoPinEdge(.left, to: .right, of: lblRank, withOffset: 10)
        
        lblLeaderQuestionsAnswered.autoPinEdge(.top, to: .bottom, of: lblRabbitsRanking, withOffset: 10)
        lblLeaderQuestionsAnswered.autoPinEdge(.left, to: .right, of: lblRankTitle)
        lblLeaderQuestionsAnswered.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
    }
    
    static func height() -> CGFloat {
        return 40 + 20 + //list button height 40
            NSAttributedString(string: "Rabbits Ranking", attributes: Style.avenirh_large_white).height(forWidth: Screen.width - 20) + 20 +
            NSAttributedString(string: "#", attributes: Style.avenirl_extra_small_white_center).height(forWidth: Screen.width - 20) + 20 + 5
    }
}

extension RabbitHeaderView {
    func selectionChange() {
        if lblIndividual.backgroundColor == Style.color.green {
            lblIndividual.backgroundColor = Style.color.grey_dark
            lblIndividual.attributedText = NSAttributedString(string: "INDIVIDUAL", attributes: Style.avenirh_medium_white_center)
            lblTeam.backgroundColor = Style.color.green
            lblTeam.attributedText = NSAttributedString(string: "TEAM", attributes: Style.avenirh_medium_grey_dark_center)
            delegate?.onSelectionChange(selection: .team)
            lblRankTitle.attributedText = NSAttributedString(string: "TEAM", attributes: Style.avenirl_extra_small_white)
        } else {
            lblIndividual.backgroundColor = Style.color.green
            lblIndividual.attributedText = NSAttributedString(string: "INDIVIDUAL", attributes: Style.avenirh_medium_grey_dark_center)
            lblTeam.backgroundColor = Style.color.grey_dark
            lblTeam.attributedText = NSAttributedString(string: "TEAM", attributes: Style.avenirh_medium_white_center)
            delegate?.onSelectionChange(selection: .individual)
            lblRankTitle.attributedText = NSAttributedString(string: "RABBIT", attributes: Style.avenirl_extra_small_white)
        }
    }
}



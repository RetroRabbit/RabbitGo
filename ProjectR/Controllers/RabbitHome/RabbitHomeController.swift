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
        tableView.register(LeaderBoardCell.self, forCellReuseIdentifier: LeaderBoardCell.reuseIdentifier)
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
        return 2
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
            let cell = tableView.dequeueReusableCell(withIdentifier: LeaderBoardCell.reuseIdentifier) as! LeaderBoardCell
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

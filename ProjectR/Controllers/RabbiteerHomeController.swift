//
//  RabbiteerHomeController.swift
//  ProjectR
//
//  Created by Wesley Buck on 2017/07/27.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import UIKit
import Material
import Icomoon

class RabbiteerHomeController : UITableNavigationController {
    static let instance = RabbiteerHomeController()
    
    fileprivate let userObject: Position = Position()
    
    fileprivate let rabbiteers: [Leader] = [
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
        tableView.register(RabbiteerHeaderCell.self, forCellReuseIdentifier: RabbiteerHeaderCell.reuseIdentifier)
        tableView.register(LeaderBoardCell.self, forCellReuseIdentifier: LeaderBoardCell.reuseIdentifier)
        tableView.alwaysBounceVertical = false
        
        /* This hides the extra separators for empty rows. See http://stackoverflow.com/a/5377569/1469018 */
        tableView.tableFooterView = UIView()
    }
    
    override func prepareToolbar() {
        setTitle("Leaderboard Position #43", subtitle: nil)
    }
}

extension RabbiteerHomeController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return rabbiteers.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: RabbiteerHeaderCell.reuseIdentifier) as! RabbiteerHeaderCell
            cell.prepareForDisplay(object: userObject)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: LeaderBoardCell.reuseIdentifier) as! LeaderBoardCell
            cell.prepareForDisplay(object: rabbiteers[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }
}

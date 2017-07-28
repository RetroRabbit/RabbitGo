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
import Firebase

class RabbiteerHomeController : UITableNavigationController {
    static let instance = RabbiteerHomeController()
    
    fileprivate var userObject: Player?
    
    fileprivate var rabbiteers: [Leader] = []
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refRabbiteers.observeSingleEvent(of: .value, with: { [weak self] snapshot in
            guard let this = self else { return }
            if let dataSnap = snapshot.children.allObjects as? [DataSnapshot] {
                this.rabbiteers = dataSnap.flatMap({ snap -> Leader? in
                    if let name = snap.childSnapshot(forPath: "displayName").value as? String,
                        let score = snap.childSnapshot(forPath: "score").value as? Int {
                        
                        if currentUserId() == snap.key {
                            this.userObject = Player.decode(snapshot: snap)
                            return Leader(code: snap.key, name: name, questionsAnswered: Int64(score), currentUser: true)
                        } else {
                            return Leader(code: snap.key, name: name, questionsAnswered: Int64(score))
                        }
                    }
                    return nil
                })
                
                this.rabbiteers.sort { $0.questionsAnswered > $1.questionsAnswered }
                
                var temp: [Leader] = []
                
                for (index, object) in this.rabbiteers.enumerated() {
                    let prevIndex = (index-1)
                    
                    if prevIndex < 0 {
                        temp.append(Leader(position: 1, code: object.code, name: object.name, questionsAnswered: object.questionsAnswered, currentUser: object.currentUser))
                    } else {
                        let prevObject = temp[prevIndex]
                        if prevObject.questionsAnswered == object.questionsAnswered {
                            temp.append(Leader(position: prevObject.position, code: object.code, name: object.name, questionsAnswered: object.questionsAnswered, currentUser: object.currentUser))
                        } else {
                            temp.append(Leader(position: prevObject.position + 1, code: object.code, name: object.name, questionsAnswered: object.questionsAnswered, currentUser: object.currentUser))
                        }
                    }
                }
                
                self?.rabbiteers = temp
                
                this.userObject?.individualRanking = Int64(self?.rabbiteers.first(where: { leader -> Bool in return leader.code == currentUserId() })?.position ?? 0)
                    
                self?.tableView.reloadData()
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.register(RabbiteerHeaderCell.self, forCellReuseIdentifier: RabbiteerHeaderCell.reuseIdentifier)
        tableView.register(LeaderBoardCell.self, forCellReuseIdentifier: LeaderBoardCell.reuseIdentifier)
        tableView.alwaysBounceVertical = false
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        
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

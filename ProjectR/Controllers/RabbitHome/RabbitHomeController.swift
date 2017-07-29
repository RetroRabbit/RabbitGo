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
import Firebase
import FirebaseAuth
import RxSwift

struct Leader {
    var position: Int = 0
    var code: String = ""
    var name: String = ""
    var questionsAnswered: Int64 = 0
    var currentUser: Bool = false
    
    init(code: String, name: String, questionsAnswered: Int64) {
        self.code = code
        self.name = name
        self.questionsAnswered = questionsAnswered
    }
    
    init(position: Int, code: String, name: String, questionsAnswered: Int64, currentUser: Bool) {
        self.position = position
        self.code = code
        self.name = name
        self.questionsAnswered = questionsAnswered
        self.currentUser = currentUser
    }
    
    init(code: String, name: String, questionsAnswered: Int64, currentUser: Bool) {
        self.code = code
        self.name = name
        self.questionsAnswered = questionsAnswered
        self.currentUser = currentUser
    }
}

class RabbitHomeController : UITableNavigationController {
    static let instance = RabbitHomeController()
    
    var currentSelection: Selection = Selection.individual
    
    fileprivate var userObject: Rabbit?
    
    fileprivate var leaders: [Leader] = []
    
    fileprivate var teams: [Leader] = []
    
    fileprivate var reload: PublishSubject = PublishSubject<()>()
    
    init() {
        super.init(hiding: NavigationHide.toBottom)
        
        view.backgroundColor = Style.color.grey_dark
        
        tabBarItem.setTitleTextAttributes(Style.avenirh_xsmall_white_center, for: .normal)
        tabBarItem.title = "Home"
        tabBarItem.image = UIImage.iconWithName(Icomoon.Icon.Home, textColor: Material.Color.white, fontSize: 20).withRenderingMode(.alwaysOriginal)
        tabBarItem.selectedImage = UIImage.iconWithName(Icomoon.Icon.Home, textColor: Style.color.green, fontSize: 20).withRenderingMode(.alwaysOriginal)
        tableView.allowsMultipleSelectionDuringEditing = false
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        
        _ = reload.debounce(0.1, scheduler: MainScheduler.instance).subscribe(onNext: { [weak self] _ in
            self?.tableView.reloadData()
        })
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.userObject == nil {
            self.userObject = firebaseRabbits.first(where: { leader -> Bool in return leader.email == currentUserEmail() })
        }
        
        fetchRelevantData()
    }
    
    func fetchRelevantData() {
        refRabbitBoard.observeSingleEvent(of: .value, with: { [weak self] boardSnapshot in
            guard let this = self else { return }
            
            if let dataSnap = boardSnapshot.children.allObjects as? [DataSnapshot],
                let code = this.userObject?.code {
                this.leaders = dataSnap.flatMap({ dataSnap -> Leader in
                    let answersSnap = dataSnap.children.allObjects as! [DataSnapshot]
                    let questionsAnswered = answersSnap.flatMap({ snap -> Int64 in
                        let bool = snap.value as? Bool ?? false
                        return bool ? 1 : 0
                    }).reduce(0, +)
                    
                    var leader = Leader(code: dataSnap.key, name: firebaseRabbits.first(where: { leader -> Bool in return leader.code == dataSnap.key })?.displayName ?? "", questionsAnswered: questionsAnswered)
                    if dataSnap.key == code {
                        leader.currentUser = true
                        self?.userObject?.questionsAnswered = leader.questionsAnswered
                    }
                    return leader
                })
                
                this.leaders.sort { $0.questionsAnswered > $1.questionsAnswered }
                
                var temp: [Leader] = []
                
                for (index, object) in this.leaders.enumerated() {
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
                
                this.leaders = temp
                
                this.userObject?.individualRanking = Int64(self?.leaders.first(where: { leader -> Bool in return leader.code == code })?.position ?? 0)
                this.reload.onNext(())
            }
        })
        
        refRabbitTeamBoard.observeSingleEvent(of: .value, with: { [weak self] teamSnapshot in
            guard let this = self else { return }
            
            if let dataSnap = teamSnapshot.children.allObjects as? [DataSnapshot],
                let code = this.userObject?.team {
                this.teams = dataSnap.flatMap({ dataSnap -> Leader in
                    let answersSnap = dataSnap.children.allObjects as! [DataSnapshot]
                    let questionsAnswered = answersSnap.flatMap({ snap -> Int64 in
                        let bool = snap.value as? Bool ?? false
                        return bool ? 1 : 0
                    }).reduce(0, +)
                    var leader = Leader(code: dataSnap.key, name: dataSnap.key, questionsAnswered: questionsAnswered)
                    if dataSnap.key == code {
                        leader.currentUser = true
                    }
                    return leader
                })
                
                this.teams.sort { $0.questionsAnswered > $1.questionsAnswered }
                
                var temp: [Leader] = []
                
                for (index, object) in this.teams.enumerated() {
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
                
                this.teams = temp
                
                this.userObject?.teamRanking = Int64(self?.teams.first(where: { leader -> Bool in return leader.code == code })?.position ?? 0)
                this.reload.onNext(())
            }
        })
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
            view.setCurrentSelection(selection: currentSelection)
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
        tableView.reloadSections([1], with: .automatic)
    }
}

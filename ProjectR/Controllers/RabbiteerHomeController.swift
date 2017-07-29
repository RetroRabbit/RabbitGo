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
import RxSwift

class RabbiteerHomeController : UITableNavigationController {
    static let instance = RabbiteerHomeController()
    
    internal var userObject: Player?
    
    fileprivate var rabbiteers: [Leader] = []
    
    init() {
        super.init(hiding: NavigationHide.toBottom)
        
        view.backgroundColor = Style.color.grey_dark
        
        tabBarItem.setTitleTextAttributes(Style.avenirh_xsmall_white_center, for: .normal)
        tabBarItem.title = "Home"
        tabBarItem.image = UIImage.iconWithName(Icomoon.Icon.Home, textColor: Material.Color.white, fontSize: 20).withRenderingMode(.alwaysOriginal)
        tabBarItem.selectedImage = UIImage.iconWithName(Icomoon.Icon.Home, textColor: Style.color.green, fontSize: 20).withRenderingMode(.alwaysOriginal)
        tableView.allowsMultipleSelectionDuringEditing = false
        
        // Configure the firebase source
        _ = onChangeListener()
            .debounce(1, scheduler: MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { _ in
                self.sort()
            })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onChangeListener() -> Observable<()> {
        return Observable.create { observable in
            _ = refRabbiteers.observe(DataEventType.childAdded, with: { snapshot in
                if let name = snapshot.childSnapshot(forPath: "displayName").value as? String,
                    let score = snapshot.childSnapshot(forPath: "score").value as? Int {
                    
                    if currentUserId() == snapshot.key {
                        self.userObject = Player.decode(snapshot: snapshot)
                        self.rabbiteers.append(Leader(code: snapshot.key, name: name, questionsAnswered: Int64(score), currentUser: true))
                    } else {
                        self.rabbiteers.append(Leader(code: snapshot.key, name: name, questionsAnswered: Int64(score)))
                    }
                    
                    observable.onNext()
                }
            })
            
            _ = refRabbiteers.observe(DataEventType.childChanged, with: { snapshot in
                if let index = self.rabbiteers.index(where: { object -> Bool in object.code == snapshot.key }),
                    let name = snapshot.childSnapshot(forPath: "displayName").value as? String,
                    let score = snapshot.childSnapshot(forPath: "score").value as? Int {
                    self.rabbiteers[index].update(name: name, questionsAnswered: Int64(score))
                    observable.onNext()
                }
            })
            
            return Disposables.create()
        }
    }
    
    func sort() {
        DispatchQueue.main.async {
            self.rabbiteers.sort { $0.questionsAnswered > $1.questionsAnswered }
            
            for (index, object) in self.rabbiteers.enumerated() {
                let prevIndex = (index-1)
                
                if prevIndex < 0 {
                    self.rabbiteers[index].update(position: 1)
                } else {
                    let prevObject = self.rabbiteers[prevIndex]
                    if prevObject.questionsAnswered == object.questionsAnswered {
                        self.rabbiteers[index].update(position: prevObject.position)
                    } else {
                        self.rabbiteers[index].update(position: prevObject.position + 1)
                    }
                }
            }
            
            if let user = self.rabbiteers.first(where: { leader -> Bool in return leader.code == currentUserId() }) {
                self.userObject?.score = user.questionsAnswered
                self.userObject?.individualRanking = Int64(user.position)
                ProfileController.instance.prepareToolbar()
                QuestionsController.instance.prepareToolbar()
                RabbiteerHomeController.instance.prepareToolbar()
            }
            
            self.tableView.reloadData()
        }
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
        setTitle("Leaderboard Position #\(RabbiteerHomeController.instance.userObject?.individualRanking ?? 0)", subtitle: nil)
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

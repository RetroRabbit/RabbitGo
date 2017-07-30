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
    
    mutating func update(position: Int) {
        self.position = position
    }
    
    mutating func update(name: String, questionsAnswered: Int64) {
        self.name = name
        self.questionsAnswered = questionsAnswered
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
        tabBarItem.image = UIImage(named: "home")?.withRenderingMode(.alwaysOriginal).tint(with: Style.color.white)
        tabBarItem.selectedImage = UIImage(named: "home")?.withRenderingMode(.alwaysOriginal).tint(with: Style.color.green)
        tableView.allowsMultipleSelectionDuringEditing = false
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        
        _ = reload.debounce(0.1, scheduler: MainScheduler.instance).subscribe(onNext: { [weak self] _ in
            self?.tableView.reloadData()
        })
        
        if self.userObject == nil {
            self.userObject = firebaseRabbits.first(where: { leader -> Bool in return leader.email == currentUserEmail() })
        }
        
        // Configure the firebase source
        _ = onChangeListenerRabbitTeamBoard()
            .debounce(1, scheduler: MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { _ in
                self.sortTeamBoard()
            })
        
        _ = onChangeListenerRabbitBoard()
            .debounce(1, scheduler: MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { _ in
                self.sortRabbitBoard()
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
        setTitle("Leaderboard Position #\(RabbiteerHomeController.instance.userObject?.individualRanking ?? 0)", subtitle: nil)
    }
    
    func onChangeListenerRabbitTeamBoard() -> Observable<()> {
        return Observable.create { observable in
            _ = refRabbitTeamBoard.observe(DataEventType.childAdded, with: { snapshot in
                if let code = self.userObject?.team {
                    let answersSnap = snapshot.children.allObjects as! [DataSnapshot]
                    let questionsAnswered = answersSnap.flatMap({ snap -> Int64 in
                        let bool = snap.value as? Bool ?? false
                        return bool ? 1 : 0
                    }).reduce(0, +)
                    
                    var leader = Leader(code: snapshot.key, name: snapshot.key, questionsAnswered: questionsAnswered)
                    if snapshot.key == code {
                        leader.currentUser = true
                    }
                    self.teams.append(leader)
                    observable.onNext()
                }
            })
            
            _ = refRabbitTeamBoard.observe(DataEventType.childChanged, with: { snapshot in
                if let index = self.teams.index(where: { object -> Bool in object.code == snapshot.key }) {
                    let answersSnap = snapshot.children.allObjects as! [DataSnapshot]
                    let questionsAnswered = answersSnap.flatMap({ snap -> Int64 in
                        let bool = snap.value as? Bool ?? false
                        return bool ? 1 : 0
                    }).reduce(0, +)
                    
                    self.teams[index].update(name: snapshot.key, questionsAnswered: questionsAnswered)
                    observable.onNext()
                    
                }
            })
            
            
            return Disposables.create()
        }
    }
    
    func onChangeListenerRabbitBoard() -> Observable<()> {
        return Observable.create { observable in
            _ = refRabbitBoard.observe(DataEventType.childAdded, with: { snapshot in
                if let code = self.userObject?.code {
                    let answersSnap = snapshot.children.allObjects as! [DataSnapshot]
                    let questionsAnswered = answersSnap.flatMap({ snap -> Int64 in
                        let bool = snap.value as? Bool ?? false
                        return bool ? 1 : 0
                    }).reduce(0, +)
                    
                    var leader = Leader(code: snapshot.key, name: firebaseRabbits.first(where: { leader -> Bool in return leader.code == snapshot.key })?.displayName ?? "", questionsAnswered: questionsAnswered)
                    if snapshot.key == code {
                        leader.currentUser = true
                        self.userObject?.questionsAnswered = leader.questionsAnswered
                    }
                    self.leaders.append(leader)
                    observable.onNext()
                }
            })
            
            _ = refRabbitBoard.observe(DataEventType.childChanged, with: { snapshot in
                if let code = self.userObject?.code,
                    let index = self.leaders.index(where: { object -> Bool in object.code == snapshot.key }) {
                    let answersSnap = snapshot.children.allObjects as! [DataSnapshot]
                    let questionsAnswered = answersSnap.flatMap({ snap -> Int64 in
                        let bool = snap.value as? Bool ?? false
                        return bool ? 1 : 0
                    }).reduce(0, +)
                    
                    if snapshot.key == code {
                        self.userObject?.questionsAnswered = questionsAnswered
                    }
                    self.leaders[index].update(name: firebaseRabbits.first(where: { leader -> Bool in return leader.code == snapshot.key })?.displayName ?? "", questionsAnswered: questionsAnswered)
                    observable.onNext()
                    
                }
            })
            
            return Disposables.create()
        }
    }
    
    func sortTeamBoard() {
        DispatchQueue.main.async {
            self.teams.sort { $0.questionsAnswered > $1.questionsAnswered }
            
            for (index, object) in self.teams.enumerated() {
                let prevIndex = (index-1)
                
                if prevIndex < 0 {
                    self.teams[index].update(position: 1)
                } else {
                    let prevObject = self.teams[prevIndex]
                    if prevObject.questionsAnswered == object.questionsAnswered {
                        self.teams[index].update(position: prevObject.position)
                    } else {
                        self.teams[index].update(position: prevObject.position + 1)
                    }
                }
            }
            if let code = self.userObject?.team {
            self.userObject?.teamRanking = Int64(self.teams.first(where: { leader -> Bool in return leader.code == code })?.position ?? 0)
            }
            self.reload.onNext(())
        }
    }
    
    func sortRabbitBoard() {
        DispatchQueue.main.async {
            if let code = self.userObject?.code {
                
                self.leaders.sort { $0.questionsAnswered > $1.questionsAnswered }
                
                for (index, object) in self.leaders.enumerated() {
                    let prevIndex = (index-1)
                    
                    if prevIndex < 0 {
                        self.leaders[index].update(position: 1)
                    } else {
                        let prevObject = self.leaders[prevIndex]
                        if prevObject.questionsAnswered == object.questionsAnswered {
                            self.leaders[index].update(position: prevObject.position)
                        } else {
                            self.leaders[index].update(position: prevObject.position + 1)
                        }
                    }
                }
                
                self.userObject?.individualRanking = Int64(self.leaders.first(where: { leader -> Bool in return leader.code == code })?.position ?? 0)
                self.reload.onNext(())
            }
        }
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

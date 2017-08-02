//
//  QuestionsController.swift
//  ProjectR
//
//  Created by Wesley Buck on 2017/07/17.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import UIKit
import Material
import Firebase
import RxSwift

struct QuestionView {
    var code: String = ""
    var celebrityCode: String = ""
    var state: Int64 = 0
    var image: UIImageView = UIImageView(image: UIImage(named: "image_square_grey"))
    var lockedCodes: [String] = []
    var profileImage: UIImage? = nil
    
    init(code: String, state: Int64, lockedCodes: [String]) {
        self.code = code
        self.state = state
        self.lockedCodes = lockedCodes
    }
    
    init(code: String, state: Int64, image: UIImageView, lockedCodes: [String]) {
        self.code = code
        self.state = state
        self.image = image
        self.lockedCodes = lockedCodes
    }
    
    init(image: UIImageView) {
        self.image = image
        self.image.contentMode = .scaleAspectFit
        self.image.clipsToBounds = true
    }
    
    mutating func update(state: Int64, image: UIImageView) {
        self.state = state
        self.image = image
        self.image.contentMode = .scaleAspectFit
        self.image.clipsToBounds = true
    }
    
    mutating func update(state: Int64, image: UIImageView, lockedCodes: [String]) {
        self.state = state
        self.image = image
        self.image.contentMode = .scaleAspectFit
        self.image.clipsToBounds = true
        self.lockedCodes = lockedCodes
    }
    
    mutating func update(code: String) {
        self.code = code
    }
    
    mutating func update(celebrityCode: String) {
        self.celebrityCode = celebrityCode
    }
    
    mutating func update(celebrityCode: String, profileImage: UIImage?) {
        self.celebrityCode = celebrityCode
        self.profileImage = profileImage
    }
}


class QuestionsController: UIViewNavigationController {
    static let instance = QuestionsController()
    fileprivate let scrollView = UIScrollView(forAutoLayout: ())
    fileprivate let strLocked = "image_square_grey"
    fileprivate let strUnlocked = "image_square_white"
    fileprivate let strAnswered = "image_square_green"
    
    internal var questions: [QuestionView] = []
    
    private let lblHeading: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.attributedText = NSAttributedString(string: "Rabbit Q’s", attributes: Style.avenirh_extra_large_white)
        return label
    }()
    
    private let imgViewDivider = UIImageView(image: UIImage(named: "textfield_line"))
    
    fileprivate lazy var QuestionsCollection: UICollectionView = {
        let layout = QuestionsLayout()
        layout.delegate = self
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: 0), collectionViewLayout: layout)
        collection.backgroundColor = Style.color.grey_dark
        collection.dataSource = self
        collection.delegate = self
        collection.contentInset = UIEdgeInsets(top: 4, left: 0, bottom: 107, right: 0)
        collection.isScrollEnabled = false
        collection.register(QuestionsCell.self, forCellWithReuseIdentifier: QuestionsCell.reuseIdentifier)
        return collection
    }()
    
    init() {
        super.init()
        tabBarItem.setTitleTextAttributes(Style.avenirh_xsmall_white_center, for: .normal)
        tabBarItem.title = "Rabbit Q,s"
        tabBarItem.image = UIImage(named: "questions")?.withRenderingMode(.alwaysOriginal).tint(with: Style.color.white)
        tabBarItem.selectedImage = UIImage(named: "questions")?.withRenderingMode(.alwaysOriginal).tint(with: Style.color.green)
        
        //added
        refCurrentUserQuestions().observeSingleEvent(of: .value, with: { (snapshot) in
            snapshot.children.forEach({ object in
                if let answeredQuestion = object as? DataSnapshot,
                    let state = answeredQuestion.childSnapshot(forPath: "state").value as? Int {
                    
                    var lockedCodes: [String] = []
                    if let _lockedCodes = answeredQuestion.childSnapshot(forPath: "lockedCodes").value as? String {
                        lockedCodes = _lockedCodes.components(separatedBy: ",")
                    }
                    
                    self.questions.append(QuestionView(code: answeredQuestion.key, state: Int64(state), lockedCodes: lockedCodes))
                    
                    if state > 0,
                        let qIndex = self.questions.index(where: { obj -> Bool in return obj.code == answeredQuestion.key }) {
                        _ = self.getPicture(code: answeredQuestion.key, state: Int64(state)).subscribe(onNext: { image in
                            self.questions[qIndex].update(state: Int64(state), image: image)
                            DispatchQueue.main.async {
                                self.QuestionsCollection.reloadItems(at: [IndexPath(row: qIndex, section: 0)])
                            }
                        })
                    }
                    
                }
            })
        })
        
        //need to listen on main node can't listen on subnode
        _ = refCurrentUser().observe(.childChanged, with: { snapshot in
            snapshot.children.allObjects.forEach({ object in
                if let answeredQuestion = object as? DataSnapshot,
                    let state = answeredQuestion.childSnapshot(forPath: "state").value as? Int,
                    let qIndex = self.questions.index(where: { obj -> Bool in return obj.code == answeredQuestion.key }),
                    self.questions[qIndex].state != Int64(state) {
                    
                    var lockedCodes: [String] = []
                    if let _lockedCodes = answeredQuestion.childSnapshot(forPath: "lockedCodes").value as? String {
                        lockedCodes = _lockedCodes.components(separatedBy: ",")
                    }
                    
                    _ = self.getPicture(code: answeredQuestion.key, state: Int64(state)).subscribe(onNext: { image in
                        self.questions[qIndex].update(state: Int64(state), image: image, lockedCodes: lockedCodes)
                        DispatchQueue.main.async {
                            self.QuestionsCollection.reloadItems(at: [IndexPath(row: qIndex, section: 0)])
                        }
                    })
                }
            })
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Style.color.grey_dark
        
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        scrollView.addSubview(lblHeading)
        scrollView.addSubview(imgViewDivider)
        scrollView.addSubview(QuestionsCollection)
    }
    
    func getPicture(code: String, state: Int64) -> Observable<UIImageView> {
        return Observable.create { [weak self] observable in
            guard let this = self else { return Disposables.create() }
            switch state {
            case 0:
                observable.onNext(UIImageView(image: UIImage(named: "image_square_grey")))
                observable.onCompleted()
            case 1:
                if let rabbitCode = firebaseQuestions.first(where: { obj -> Bool in return code == obj.qrCode })?.unlocked {
                    rabbitProfilePic(rabbitCode: "\(rabbitCode)_line").getData(maxSize: 1 * 1024 * 1024, completion: { (data, error) in
                        if let _ = error {
                            print("ffuuuccckkk")
                        } else {
                            let imageView = UIImageView(image: UIImage(named: "image_square_white"))
                            let image = UIImageView(image: UIImage(data: data!))
                            imageView.addSubview(image)
                            imageView.bringSubview(toFront: image)
                            image.autoPinEdge(toSuperviewEdge: .top, withInset: 5)
                            image.autoPinEdge(toSuperviewEdge: .bottom, withInset: 5)
                            image.autoPinEdge(toSuperviewEdge: .left, withInset: 5)
                            image.autoPinEdge(toSuperviewEdge: .right, withInset: 5)
                            
                            if let qIndex = this.questions.index(where: { obj -> Bool in return obj.code == code }) {
                                this.questions[qIndex].update(celebrityCode: rabbitCode)
                            }
                            
                            observable.onNext(imageView)
                        }
                        observable.onCompleted()
                    })
                } else {
                    observable.onCompleted()
                }
            case 2:
                if let rabbitCode = firebaseQuestions.first(where: { obj -> Bool in return code == obj.qrCode })?.unlocked {
                    rabbitProfilePic(rabbitCode: rabbitCode).getData(maxSize: 1 * 1024 * 1024, completion: { (data, error) in
                        if let _ = error {
                        } else {
                            let imageView = UIImageView(image: UIImage(named: "image_square_green"))
                            let profileImage = UIImage(data: data!)
                            let image = UIImageView(image: UIImage(data: data!))
                            imageView.addSubview(image)
                            imageView.bringSubview(toFront: image)
                            image.autoPinEdge(toSuperviewEdge: .top, withInset: 5)
                            image.autoPinEdge(toSuperviewEdge: .bottom, withInset: 5)
                            image.autoPinEdge(toSuperviewEdge: .left, withInset: 5)
                            image.autoPinEdge(toSuperviewEdge: .right, withInset: 5)
                            
                            if let qIndex = this.questions.index(where: { obj -> Bool in return obj.code == code }) {
                                this.questions[qIndex].update(celebrityCode: rabbitCode, profileImage: profileImage)
                            }
                            
                            observable.onNext(imageView)
                        }
                        observable.onCompleted()
                    })
                } else {
                    observable.onCompleted()
                }
            default:
                observable.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    override func prepareToolbar() {
        setTitle("Leaderboard Position #\(RabbiteerHomeController.instance.userObject?.individualRanking ?? 0)", subtitle: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.autoPinEdgesToSuperviewEdges()
        
        lblHeading.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
        lblHeading.autoAlignAxis(toSuperviewAxis: .vertical)
        
        imgViewDivider.autoPinEdge(.top, to: .bottom, of: lblHeading, withOffset: -30)
        imgViewDivider.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        imgViewDivider.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
        
        QuestionsCollection.autoSetDimension(.height, toSize: QuestionsCell.calculateHeight() * CGFloat(questions.count / 3))
        
        QuestionsCollection.autoSetDimension(.width, toSize: Screen.width)
        QuestionsCollection.autoPinEdge(.top, to: .bottom, of: imgViewDivider)
        QuestionsCollection.autoPinEdge(toSuperviewEdge: .left)
        QuestionsCollection.autoPinEdge(toSuperviewEdge: .right)
        QuestionsCollection.autoPinEdge(toSuperviewEdge: .bottom)
        
        scrollView.contentSize = CGSize(width: Screen.width, height: QuestionsCollection.frame.bottom + 20)
    }
}

extension QuestionsController: QuestionsDelegate {
    func collectionView(collectionView: UICollectionView, heightAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        return QuestionsCell.calculateHeight()
    }
}

extension QuestionsController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuestionsCell.reuseIdentifier, for: indexPath) as! QuestionsCell
        cell.prepareForDisplay(image: questions[indexPath.row].image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Shhhhh Wesley, our secret
        let reAdjustedIndex = indexPath.item % 3 == 0 ? indexPath.item + 2 : indexPath.item - 1
        let playerQuestion = questions[indexPath.item]
        switch playerQuestion.state {
        case 1:
            if let question = firebaseQuestions.first(where: { object -> Bool in return object.qrCode == playerQuestion.code }) {
                self.pushViewController(QuestionController(question: question, index: reAdjustedIndex, lockedCodes: playerQuestion.lockedCodes), animated: true)
            }
        case 2:
            self.pushViewController(BioController(celebrityCode: playerQuestion.celebrityCode, image: playerQuestion.profileImage), animated: true)
            break
        default:
            // Locked question tap
            let ac = UIAlertController(title: "Locked question", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Please scan the relevant QR code", style: .default))
            present(ac, animated: true)
        }
    }
}

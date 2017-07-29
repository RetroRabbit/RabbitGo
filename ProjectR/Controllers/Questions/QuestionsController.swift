//
//  QuestionsController.swift
//  ProjectR
//
//  Created by Wesley Buck on 2017/07/17.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import UIKit
import Material
import Icomoon
import Firebase
import RxSwift

struct QuestionView {
    var code: String = ""
    var celebrityCode: String = ""
    var state: Int64 = 0
    var image: UIImage? = UIImage(named: "image_square_grey")
    
    init(code: String, state: Int64, image: UIImage?) {
        self.code = code
        
        self.state = state
        self.image = image
    }
    
    init(image: UIImage?) {
        self.image = image
    }
    
    mutating func update(state: Int64, image: UIImage?) {
        self.state = state
        self.image = image
    }
    
    mutating func update(code: String) {
        self.code = code
    }
    
    mutating func update(celebrityCode: String) {
        self.celebrityCode = celebrityCode
    }
}


class QuestionsController: UIViewNavigationController {
    static let instance = QuestionsController()
    fileprivate let scrollView = UIScrollView(forAutoLayout: ())
    fileprivate let strLocked = "image_square_grey"
    fileprivate let strUnlocked = "image_square_white"
    fileprivate let strAnswered = "image_square_green"
    
    fileprivate var profiles: [String:UIImage] = [:]
    fileprivate var questions: [QuestionView] = Array(repeating: QuestionView(image: UIImage(named: "image_square_grey")), count: 21)
    
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
        tabBarItem.image = UIImage.iconWithName(Icomoon.Icon.Questions, textColor: Material.Color.white, fontSize: 20).withRenderingMode(.alwaysOriginal)
        tabBarItem.selectedImage = UIImage.iconWithName(Icomoon.Icon.Questions, textColor: Style.color.green, fontSize: 20).withRenderingMode(.alwaysOriginal)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }
    
    func refresh() {
        refCurrentUserQuestions().observeSingleEvent(of: .value, with: { [weak self] (snapshot) in
            guard let this = self else { return }
            
            if let _ = this.questions.index(where: { obj -> Bool in return obj.code.isEmpty }) { this.populateKeys(snapshot: snapshot) }
            
            snapshot.children.forEach({ object in
                if let answeredQuestion = object as? DataSnapshot,
                    let state = answeredQuestion.childSnapshot(forPath: "state").value as? Int64,
                    let qIndex = this.questions.index(where: { obj -> Bool in return obj.code == answeredQuestion.key }),
                    this.questions[qIndex].state != state {
                    _ = this.getPicture(code: answeredQuestion.key, state: state).subscribe(onNext: { image in
                        this.questions[qIndex].update(state: state, image: image)
                        this.QuestionsCollection.reloadItems(at: [IndexPath(row: qIndex, section: 0)])
                    })
                }
            })
        })
    }
    
    func populateKeys(snapshot: DataSnapshot) {
        for (index, object) in snapshot.children.enumerated() {
            if let answeredQuestion = object as? DataSnapshot {
                    self.questions[index].update(code: answeredQuestion.key)
            }
        }
    }
    
    func getPicture(code: String, state: Int64) -> Observable<UIImage?> {
        return Observable.create { [weak self] observable in
            guard let this = self else { return Disposables.create() }
            
            switch state {
            case 0:
                observable.onNext(UIImage(named: "image_square_grey"))
                observable.onCompleted()
            case 1:
                observable.onNext(UIImage(named: "image_square_white"))
                observable.onCompleted()
            case 2:
                if let rabbitCode = firebaseQuestions.first(where: { obj -> Bool in return code == obj.qrCode })?.unlocked {
                    if let image = this.profiles[rabbitCode] {
                        observable.onNext(image)
                        observable.onCompleted()
                    } else {
                        rabbitProfilePic(rabbitCode: rabbitCode).getData(maxSize: 1 * 1024 * 1024, completion: { (data, error) in
                            if let _ = error {
                                observable.onNext(UIImage(named: "image_square_grey"))
                            } else {
                                let image = UIImage(data: data!)
                                this.profiles[rabbitCode] = image
                                if let qIndex = this.questions.index(where: { obj -> Bool in return obj.code == code }) {
                                    this.questions[qIndex].update(celebrityCode: rabbitCode)
                                }
                                
                                observable.onNext(image)
                            }
                            observable.onCompleted()
                        })
                    }
                } else {
                    observable.onCompleted()
                }
            default:
                observable.onNext(UIImage(named: "image_square_grey"))
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

extension QuestionsController: QuestionDelegate {
    
    //NNNNOOOOOO
    func answeredQuestion(index item: Int, selectedIndex indexPath: IndexPath) {
        //questions[indexPath.row] = "image_square_green"
        //QuestionsCollection.reloadItems(at: [indexPath])
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
        cell.prepareForDisplay(image: questions[indexPath.row].image ?? UIImage(named: "image_square_grey")!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Shhhhh Wesley, our secret
        let reAdjustedIndex = indexPath.item % 3 == 0 ? indexPath.item + 2 : indexPath.item - 1
        let question = questions[indexPath.item]
        switch question.state {
        case 1:
            let vc = QuestionController(question: firebaseQuestions[indexPath.item], index: reAdjustedIndex, selectedIndex: indexPath, delegate: self)
            self.pushViewController(vc, animated: true)
        case 2:
            self.pushViewController(BioController(celebrityCode: question.celebrityCode), animated: true)
            break
        default:
            // Locked question tap
            let ac = UIAlertController(title: "Locked question", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Please scan the relevant QR code", style: .default))
            present(ac, animated: true)
        }
    }
}

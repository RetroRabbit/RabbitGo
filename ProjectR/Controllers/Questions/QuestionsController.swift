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

class QuestionsController: UIViewNavigationController {
    static let instance = QuestionsController()
    
    fileprivate let scrollView = UIScrollView(forAutoLayout: ())
    
    fileprivate var questions: [String] = [
        "image_square_grey",
        "image_square_grey",
        "image_square_grey",
        "image_square_grey",
        "image_square_grey",
        "image_square_grey",
        "image_square_grey",
        "image_square_grey",
        "image_square_grey",
        "image_square_grey",
        "image_square_grey",
        "image_square_grey",
        "image_square_grey",
        "image_square_grey",
        "image_square_grey",
        "image_square_grey",
        "image_square_grey",
        "image_square_grey",
        "image_square_grey",
        "image_square_grey",
        "image_square_grey"
    ]
    
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
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collection.backgroundColor = Material.Color.grey.lighten4
        collection.dataSource = self
        collection.delegate = self
        collection.contentInset = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
        collection.isScrollEnabled = false
        collection.backgroundColor = Style.color.grey_dark
        collection.register(QuestionsCell.self, forCellWithReuseIdentifier: QuestionsCell.reuseIdentifier)
        collection.contentInset = UIEdgeInsets(top: 4, left: 4, bottom: 107, right: 4)
        return collection
    }()
    
    init() {
        super.init()
        tabBarItem.setTitleTextAttributes(Style.avenirh_xsmall_white_center, for: .normal)
        tabBarItem.title = "Rabbit Q,s"
        tabBarItem.image = UIImage.iconWithName(Icomoon.Icon.Questions, textColor: Material.Color.white, fontSize: 20).withRenderingMode(.alwaysOriginal)
        tabBarItem.selectedImage = UIImage.iconWithName(Icomoon.Icon.Questions, textColor: Style.color.green, fontSize: 20).withRenderingMode(.alwaysOriginal)
        
        // Store firebase questions in a global array
        refQuestions.observeSingleEvent(of: .value, with: { (snapshot) in
            let enumerator = snapshot.children
            while let question = enumerator.nextObject() as? DataSnapshot {
                let storedQuestion = Question()
                storedQuestion.qrCode = question.key as? NSString
                storedQuestion.answer = question.childSnapshot(forPath: "answer").value as? NSNumber
                storedQuestion.text = question.childSnapshot(forPath: "text").value as? NSString
                
                var multiple: [NSString] = []
                multiple.append(question.childSnapshot(forPath: "mutiple").childSnapshot(forPath: "0").value as? NSString ?? "")
                multiple.append(question.childSnapshot(forPath: "mutiple").childSnapshot(forPath: "1").value as? NSString ?? "")
                multiple.append(question.childSnapshot(forPath: "mutiple").childSnapshot(forPath: "2").value as? NSString ?? "")
                storedQuestion.multiple = multiple
                firebaseQuestions.append(storedQuestion)
            }
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for (index, question) in firebaseQuestions.enumerated() {
            if question?.state == 1 {
                questions[index] = "image_square_white"
            } else if question?.state == 2 {
                questions[index] = "image_square_green"
            }
        }
        
        QuestionsCollection.reloadData()
    }
    
    override func prepareToolbar() {
        setTitle("Leaderboard Position #43", subtitle: nil)
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
        cell.prepareForDisplay(image: questions[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let question = firebaseQuestions[indexPath.item] {
            let vc = QuestionController(question: question, index: indexPath.item + 1)
            self.pushViewController(vc, animated: true)
        }
    }
}

//
//  QuestionsController.swift
//  ProjectR
//
//  Created by Wesley Buck on 2017/07/17.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import UIKit
import Material

class QuestionsController: UICollectionViewController {
    static let instance = QuestionsController()
    
    fileprivate let questions: [Question] = [
        Question(image: "update-kalido-image1"),
        Question(image: "update-kalido-image2"),
        Question(image: "update-kalido-image3"),
        Question(image: "update-kalido-image4"),
        Question(image: "update-kalido-image5"),
        Question(image: "update-kalido-image1"),
        Question(image: "update-kalido-image2"),
        Question(image: "update-kalido-image3"),
        Question(image: "update-kalido-image4"),
        Question(image: "update-kalido-image5")
    ]
    
    init() {
        let layout = QuestionsLayout()
        super.init(collectionViewLayout: layout)
        layout.delegate = self
        
        navigationController?.title = "Leaderboard Position #43"
        tabBarItem.title = "Questions"
        tabBarItem.image = Material.Icon.search

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = Style.color.grey_dark
        
        collectionView?.register(QuestionsCell.self, forCellWithReuseIdentifier: QuestionsCell.reuseIdentifier)
        collectionView?.contentInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    }
}

extension QuestionsController: QuestionsDelegate {
    func collectionView(collectionView: UICollectionView, heightAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        return QuestionsCell.calculateHeight()
    }
}

extension QuestionsController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuestionsCell.reuseIdentifier, for: indexPath) as! QuestionsCell
        cell.prepareForDisplay(object: questions[indexPath.row])
        return cell
    }

}

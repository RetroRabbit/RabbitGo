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
    
    fileprivate let questions: [String] = [
        "image_square_grey",//1
        "image_square_grey",//2
        "image_square_grey",//3
        "image_square_grey",//4
        "image_square_grey",//5
        "image_square_grey",//6
        "image_square_grey",//7
        "image_square_grey",//8
        "image_square_grey",//9
        "image_square_grey",//10
        "image_square_grey",//11
        "image_square_grey",//12
        "image_square_grey",//13
        "image_square_grey",//14
        "image_square_grey",//15
        "image_square_grey",//16
        "image_square_grey",//17
        "image_square_grey",//18
        "image_square_grey",//19
        "image_square_grey",//20
        "image_square_grey"//21
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
        collectionView?.contentInset = UIEdgeInsets(top: 4, left: 4, bottom: 153, right: 4)
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
        cell.prepareForDisplay(image: questions[indexPath.row])
        return cell
    }

}

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

class QuestionsController: UICollectionNavigationController {
    static let instance = QuestionsController()
    
    fileprivate let questions: [String] = [
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
    
    init() {
        let layout = QuestionsLayout()
        super.init(viewLayout: layout)
        layout.delegate = self
        //setTitleTextAttributes
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
        collectionView?.backgroundColor = Style.color.grey_dark
        
        collectionView?.register(QuestionsCell.self, forCellWithReuseIdentifier: QuestionsCell.reuseIdentifier)
        collectionView?.contentInset = UIEdgeInsets(top: 4, left: 4, bottom: 107, right: 4)
    }
    
    override func prepareToolbar() {
        setTitle("Leaderboard Position #43", subtitle: nil)
        //view.backgroundColor = Style.color.grey_dark
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

//
//  QuestionsController.swift
//  ProjectR
//
//  Created by Wesley Buck on 2017/07/17.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import Foundation
import UIKit
import Material

class QuestionsController: UICollectionViewController {
    static let instance = QuestionsController()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        //super.init(hiding: NavigationHide.toBottom)
        navigationController?.title = "Leaderboard Position #43"
        tabBarItem.title = "Questions"
        tabBarItem.image = UIImage(named: "questions")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    
    final class PhotoLayout: UICollectionViewLayout {
        weak var delegate: PhotoLayoutDelegate?
        private var scache: [Int: UICollectionViewLayoutAttributes] = [:]
        
        /* Returns the width of the collection view */
        var width: CGFloat {
            if let collectionView = collectionView {
                return collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right
            } else {
                return 0
            }
        }
        
        /* Returns the height of the collection view */
        private var height: CGFloat {
            if let collectionView = collectionView {
                return collectionView.bounds.height - collectionView.contentInset.top - collectionView.contentInset.bottom
            } else {
                return 0
            }
        }
        
        /* Returns the width of the column */
        private var columnWidth: CGFloat {
            return width / 2.0
        }
        
        /* Returns the number of items in the collection view */
        private var numberOfItems: Int {
            if let collectionView = collectionView, collectionView.numberOfSections > 0 {
                return collectionView.numberOfItems(inSection: 0)
            } else {
                return 0
            }
        }
        
        /* The total height of all the content */
        private var contentHeight: CGFloat = 0
        
        override func prepare() {
            guard let delegate = delegate, let collectionView = collectionView else { return }
            scache.removeAll(keepingCapacity: true)
            
            // 2. Pre-Calculates the X Offset for every column and adds an array to increment the currently max Y Offset for each column
            var xOffset: [CGFloat] = [0, columnWidth]
            var yOffset: [CGFloat] = [0, 0]
            
            // 3. Iterates through the list of items in the first section
            for item in 0 ..< numberOfItems {
                let indexPath = IndexPath(item: item, section: 0)
                let column = yOffset[0] > yOffset[1] ? 1 : 0
                
                // 4. Asks the delegate for the height of the picture and the annotation and calculates the cell frame.
                let height = delegate.collectionView(collectionView: collectionView, heightAtIndexPath: indexPath, withWidth: width)
                let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
                
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = frame
                
                scache[item] = attributes
                
                // 6. Updates the collection view content height
                yOffset[column] = yOffset[column] + height
                contentHeight = max(yOffset[0], yOffset[1])
            }
        }
        
        override var collectionViewContentSize: CGSize {
            return CGSize(width: width, height: contentHeight)
        }
        
        /* Return all attributes in the cache whose frame intersects with the rect passed to the method */
        override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
            var layoutAttributes = [UICollectionViewLayoutAttributes]()
            for (_, attributes) in scache {
                if attributes.frame.intersects(rect) {
                    layoutAttributes.append(attributes)
                }
            }
            return layoutAttributes
        }
        
        override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
            return scache[indexPath.item]
        }
    }
    
    protocol PhotoLayoutDelegate: class {
        //TODO: Fixed height based on ratio
        func collectionView(collectionView: UICollectionView, heightAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat
    }

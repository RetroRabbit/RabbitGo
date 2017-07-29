//
//  QuestionsCell.swift
//  ProjectR
//
//  Created by Wesley Buck on 2017/07/26.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import Material

class QuestionsCell: CollectionViewCell {
    /* State */
    class var reuseIdentifier: String { return "QuestionsCell" }
    
    /* Interface */
    fileprivate let imgMedia: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imgMedia)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func prepareForDisplay(image: UIImage) {
        imgMedia.image =  image
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        /* Clear cell state */
        
        /* Clear cell UI */
        imgMedia.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageWidth = ((Screen.width) / 3.0) - 8
        imgMedia.frame = CGRect(origin: CGPoint(x: 4, y: 4), size: CGSize(width: imageWidth, height: imageWidth))
    }
    
    class func calculateHeight() -> CGFloat {
        let imageWidth = ((Screen.width) / 3.0)
        return imageWidth + 8
    }
}

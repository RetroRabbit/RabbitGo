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
    
    func prepareForDisplay(image: String) {
        imgMedia.image =  UIImage(named: image)
    }

    
    /*override func prepareForDisplay(object: ProfileSwitchObject, otherProfile: Bool = true) {
        super.prepareForDisplay(object: object, otherProfile: otherProfile)
        key = object.key
        
        let imageWidth = ProfileXCell.calculateWidth() - 8
        let imageHeight = imageWidth / ImageHelper.decodedRatio(object.url1)
        
        if object.url1 != "", let url = ImageHelperWithKingfisherCache.getURL(path: object.url1, dimensions: .exactly(width: imageWidth, height: imageHeight)) {
            imgMedia.kf.setImage(
                with: url,
                placeholder: UIImage(color: ImageHelper.decodedColor(object.url1)),
                options: [])
            
            imgMedia.frame.size = CGSize(width: imageWidth, height: imageHeight)
            
            let rectShape = CAShapeLayer()
            rectShape.bounds = imgMedia.frame
            rectShape.position = imgMedia.center
            rectShape.path = UIBezierPath(roundedRect: imgMedia.bounds, byRoundingCorners: [.allCorners], cornerRadii: CGSize(width: 2, height: 2)).cgPath
            imgMedia.layer.mask = rectShape
        }
    }*/
    
    override func prepareForReuse() {
        super.prepareForReuse()
        /* Clear cell state */
        
        /* Clear cell UI */
        imgMedia.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageWidth = ((Screen.width) / 3.0) - 12
        imgMedia.frame = CGRect(origin: CGPoint(x: 4, y: 4), size: CGSize(width: imageWidth, height: imageWidth))
    }
    
    class func calculateHeight() -> CGFloat {
        let imageWidth = ((Screen.width) / 3.0) - 12
        return imageWidth + 8
    }
}

//
//  RabbitLeaderBoardCell.swift
//  ProjectR
//
//  Created by Wesley Buck on 2017/07/27.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import UIKit
import Material

class LeaderBoardCell: UITableViewCell {
    /* State */
    class var reuseIdentifier: String { return "LeaderBoardCell" }
    
    /* UI */
    let lblPosition: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let lblFullname: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let lblQuestionsAnswered: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = Style.color.grey_dark
        addSubview(lblPosition)
        
        contentView.backgroundColor = Style.color.grey_light
        
        contentView.addSubview(lblFullname)
        contentView.addSubview(lblQuestionsAnswered)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareForDisplay(object: Leader) {
        lblPosition.attributedText = NSAttributedString(string: "\(object.position)", attributes: Style.rhino_large_green_center)
       
        if object.currentUser {
            contentView.backgroundColor = Style.color.white
            lblFullname.attributedText = NSAttributedString(string: object.name.components(separatedBy: " ").first ?? "", attributes: Style.avenirh_large_grey_dark)
            lblQuestionsAnswered.attributedText = NSAttributedString(string: "\(object.questionsAnswered)", attributes: Style.avenirh_extra_large_grey_dark_right)
        } else {
            lblFullname.attributedText = NSAttributedString(string: object.name.components(separatedBy: " ").first ?? "", attributes: Style.avenirh_large_white)
            lblQuestionsAnswered.attributedText = NSAttributedString(string: "\(object.questionsAnswered)", attributes: Style.avenirh_extra_large_white_right)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let y = (60 - lblPosition.intrinsicContentSize.height)/2
        
        lblPosition.frame = CGRect(x: 10, y: y, width: 40, height: lblPosition.intrinsicContentSize.height)
        
        let width = Screen.width - lblPosition.frame.right - 20
        contentView.frame = CGRect(x: lblPosition.frame.right + 10, y: Style.padding.s, width: width, height: 40)
        
        lblFullname.frame = CGRect(x: 10, y: (40 - lblFullname.intrinsicContentSize.height)/2, width: lblFullname.intrinsicContentSize.width, height: lblFullname.intrinsicContentSize.height)
        
        lblQuestionsAnswered.frame = CGRect(x: width - 10 - lblQuestionsAnswered.intrinsicContentSize.width, y: (40 - lblQuestionsAnswered.intrinsicContentSize.height)/2, width: lblQuestionsAnswered.intrinsicContentSize.width, height: lblQuestionsAnswered.intrinsicContentSize.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.backgroundColor = Style.color.grey_light
        lblPosition.attributedText = nil
        lblQuestionsAnswered.attributedText = nil
        lblFullname.attributedText = nil
        
        /* Trigger mask redraw */
        setNeedsDisplay()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: size.width, height: height())
    }
    
    func height() -> CGFloat {
        return 50
    }
}

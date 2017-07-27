//
//  RabbitHeaderCell.swift
//  ProjectR
//
//  Created by Wesley Buck on 2017/07/27.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import UIKit
import Material

class RabbitHeaderCell: UITableViewCell {
    class var reuseIdentifier: String { return "RabbitHeaderCell" }
    
    private let headingBackground: UIView = {
        let view = UIView()
        view.backgroundColor = Style.color.white
        let imgViewDivider = UIImageView(image: UIImage(named: "line_divider")?.withRenderingMode(.alwaysTemplate))
        imgViewDivider.tintColor = Style.color.grey_dark
        imgViewDivider.contentMode = .scaleAspectFit
        imgViewDivider.clipsToBounds = true
        view.addSubview(imgViewDivider)
        
        imgViewDivider.autoPinEdge(toSuperviewEdge: .left)
        imgViewDivider.autoPinEdge(toSuperviewEdge: .right)
        imgViewDivider.autoPinEdge(toSuperviewEdge: .bottom, withInset: -10)
        
        return view
    }()
    
    private let lblHeading: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let lblQuestionsAnsweredLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.attributedText = NSAttributedString(string: "QUESTIONS \n ANSWERED", attributes: Style.avenirh_large_white)
        return label
    }()
    
    private let lblQuestionsAnswered: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let lblQuestionsUnanswered: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let imgViewDivider = UIImageView(image: UIImage(named: "textfield_line"))
    
    private let lblIndividualRankingHeader: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.attributedText = NSAttributedString(string: "INDIVIDUAL \n RANKING", attributes: Style.avenirh_medium_white_center)
        return label
    }()
    
    private let lblIndividualRanking: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let imgViewRankDivider = UIImageView(image: UIImage(named: "line_horizontal"))
    
    private let lblTeamRankingHeader: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.attributedText = NSAttributedString(string: "TEAM \n RANKING", attributes: Style.avenirh_medium_white_center)
        return label
    }()
    
    private let lblTeamRanking: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let marvinCage: UIView = UIView()
    
    private let imgViewMarvin = UIImageView(image: UIImage(named: "marvin"))
    
    private let lblUniqueCode: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.backgroundColor = Style.color.grey_dark
        
        headingBackground.addSubview(lblHeading)
        contentView.addSubview(headingBackground)
        contentView.addSubview(lblQuestionsAnsweredLabel)
        contentView.addSubview(lblQuestionsAnswered)
        contentView.addSubview(imgViewDivider)
        
        contentView.addSubview(lblIndividualRankingHeader)
        contentView.addSubview(imgViewRankDivider)
        contentView.addSubview(lblTeamRankingHeader)
        
        contentView.addSubview(lblIndividualRanking)
        contentView.addSubview(lblTeamRanking)
        
        contentView.addSubview(marvinCage)
        
        marvinCage.addSubview(imgViewMarvin)
        marvinCage.addSubview(lblUniqueCode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareForDisplay(object: Position) {
        lblHeading.attributedText = NSAttributedString(string: "Hi \(object.fullname)!", attributes: Style.avenirh_extra_large_grey_dark_center)
        lblQuestionsAnswered.attributedText = NSAttributedString(string: "00", attributes: Style.rhino_mega_green_center)//\(object.questionsUnanswered)"
        lblIndividualRanking.attributedText = NSAttributedString(string: "#43", attributes: Style.rhino_big_green_center)
        lblTeamRanking.attributedText = NSAttributedString(string: "#10", attributes: Style.rhino_big_green_center)
        let att = NSMutableAttributedString(attributedString: NSAttributedString(string: "Unique Rabbit-Code \n", attributes: Style.avenirl_small_green))
        att.append(NSAttributedString(string: "Frikkie123", attributes: Style.avenirh_large_green))
        lblUniqueCode.attributedText = att
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = CGRect(x: 0, y: 0, width: Screen.width, height: height())
        
        headingBackground.autoSetDimension(.height, toSize: 100)
        headingBackground.autoPinEdge(toSuperviewEdge: .top)
        headingBackground.autoPinEdge(toSuperviewEdge: .left)
        headingBackground.autoPinEdge(toSuperviewEdge: .right)
        
        lblHeading.autoCenterInSuperview()
        
        lblQuestionsAnsweredLabel.autoPinEdge(.top, to: .bottom, of: headingBackground, withOffset: 40)
        lblQuestionsAnsweredLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        
        lblQuestionsAnswered.autoSetDimension(.width, toSize: 100)
        lblQuestionsAnswered.autoPinEdge(.left, to: .right, of: lblQuestionsAnsweredLabel)
        lblQuestionsAnswered.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
        
        lblQuestionsAnswered.autoAlignAxis(.horizontal, toSameAxisOf: lblQuestionsAnsweredLabel)
        
        imgViewDivider.autoPinEdge(.top, to: .bottom, of: lblQuestionsAnsweredLabel, withOffset: -30)
        imgViewDivider.autoPinEdge(.left, to: .left, of: lblQuestionsAnsweredLabel, withOffset: 0)
        imgViewDivider.autoPinEdge(.right, to: .right, of: lblQuestionsAnswered)
        
        imgViewRankDivider.autoSetDimension(.width, toSize: 8)
        
        imgViewRankDivider.autoPinEdge(.top, to: .bottom, of: imgViewDivider, withOffset: 10)
        imgViewRankDivider.autoAlignAxis(.vertical, toSameAxisOf: imgViewDivider)
        
        lblIndividualRankingHeader.autoPinEdge(.top, to: .bottom, of: imgViewDivider, withOffset: 10)
        lblIndividualRankingHeader.autoPinEdge(.left, to: .left, of: imgViewDivider)
        lblIndividualRankingHeader.autoPinEdge(.right, to: .left, of: imgViewRankDivider)
        
        lblTeamRankingHeader.autoPinEdge(.top, to: .bottom, of: imgViewDivider, withOffset: 10)
        lblTeamRankingHeader.autoPinEdge(.right, to: .right, of: imgViewDivider)
        lblTeamRankingHeader.autoPinEdge(.left, to: .right, of: imgViewRankDivider)
        
        lblIndividualRanking.autoPinEdge(.top, to: .bottom, of: lblIndividualRankingHeader, withOffset: 20)
        lblIndividualRanking.autoPinEdge(.left, to: .left, of: lblIndividualRankingHeader)
        lblIndividualRanking.autoPinEdge(.right, to: .right, of: lblIndividualRankingHeader)
        
        lblTeamRanking.autoPinEdge(.top, to: .bottom, of: lblTeamRankingHeader, withOffset: 20)
        lblTeamRanking.autoPinEdge(.left, to: .left, of: lblTeamRankingHeader)
        lblTeamRanking.autoPinEdge(.right, to: .right, of: lblTeamRankingHeader)
        
        marvinCage.autoPinEdge(.top, to: .bottom, of: lblTeamRanking, withOffset: 30)
        marvinCage.autoAlignAxis(.vertical, toSameAxisOf: imgViewDivider)
        
        imgViewMarvin.autoPinEdge(toSuperviewEdge: .top)
        imgViewMarvin.autoPinEdge(toSuperviewEdge: .bottom)
        imgViewMarvin.autoPinEdge(toSuperviewEdge: .left)
        
        lblUniqueCode.autoPinEdge(.left, to: .right, of: imgViewMarvin)
        lblUniqueCode.autoPinEdge(toSuperviewEdge: .right)
        
        lblUniqueCode.autoAlignAxis(.horizontal, toSameAxisOf: imgViewMarvin)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: Screen.width, height: height())
    }
    
    func height() -> CGFloat {
        return
            100 + //headingBackground height
                lblQuestionsAnsweredLabel.intrinsicContentSize.height + 40 +
                imgViewDivider.intrinsicContentSize.height - 30 +
                lblIndividualRankingHeader.intrinsicContentSize.height + 10 +
                lblIndividualRanking.intrinsicContentSize.height + 20 +
                imgViewMarvin.intrinsicContentSize.height + 30 + 15
    }
}

enum Selection {
    case individual
    case team
}

protocol RabbitHeaderCellDelegate: class {
    func onSelectionChange(selection: Selection)
}

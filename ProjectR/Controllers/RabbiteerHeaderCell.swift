//
//  RabbiteerHeaderCell.swift
//  ProjectR
//
//  Created by Wesley Buck on 2017/07/27.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import UIKit
import Material

class RabbiteerHeaderCell: UITableViewCell {
    class var reuseIdentifier: String { return "RabbiteerHeaderCell" }
    
    private let lblHeading: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let imgViewDivider = UIImageView(image: UIImage(named: "textfield_line"))
    
    private let lblQuestionsAnsweredHeader: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.attributedText = NSAttributedString(string: "QUESTIONS \n ANSWERED", attributes: Style.avenirh_medium_white_center)
        return label
    }()
    
    private let lblQuestionsAnswered: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let imgViewRankDivider = UIImageView(image: UIImage(named: "line_horizontal"))
    
    private let lblRabbiteerRankingHeader: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.attributedText = NSAttributedString(string: "LEADERBOARD \n POSITION", attributes: Style.avenirh_medium_white_center)
        return label
    }()
    
    private let lblRabbiteerRanking: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    
    private let lblRabbitsRanking: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.attributedText = NSAttributedString(string: "Rabbiteer Ranking", attributes: Style.avenirh_large_white)
        return label
    }()
    
    private let lblRank: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.attributedText = NSAttributedString(string: "#", attributes: Style.avenirl_extra_small_white_center)
        return label
    }()
    
    fileprivate let lblRankTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.attributedText = NSAttributedString(string: "RABBIT", attributes: Style.avenirl_extra_small_white)
        return label
    }()
    
    private let lblLeaderQuestionsAnswered: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.attributedText = NSAttributedString(string: "QUESTIONS ANSWERED", attributes: Style.avenirl_extra_small_white_right)
        return label
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.backgroundColor = Style.color.grey_dark
        
        contentView.addSubview(lblHeading)
        contentView.addSubview(imgViewDivider)
        
        contentView.addSubview(lblQuestionsAnsweredHeader)
        contentView.addSubview(imgViewRankDivider)
        contentView.addSubview(lblRabbiteerRankingHeader)
        
        contentView.addSubview(lblQuestionsAnswered)
        contentView.addSubview(lblRabbiteerRanking)
        
        addSubview(lblRabbitsRanking)
        
        addSubview(lblRank)
        addSubview(lblRankTitle)
        addSubview(lblLeaderQuestionsAnswered)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareForDisplay(object: Player?) {
        lblHeading.attributedText = NSAttributedString(string: "Hi \(object?.displayName?.components(separatedBy: " ").first ?? "")!", attributes: Style.avenirh_extra_large_white)
        let att = NSMutableAttributedString(attributedString: NSAttributedString(string: "\(object?.score ?? 0)", attributes: Style.rhino_big_green_center))
        att.append(NSAttributedString(string: "/21", attributes: Style.rhino_large_green))
        
        lblQuestionsAnswered.attributedText = att
        lblRabbiteerRanking.attributedText = NSAttributedString(string: "#\(object?.individualRanking ?? 0)", attributes: Style.rhino_big_green_center)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = CGRect(x: 0, y: 0, width: Screen.width, height: height())
        
        lblHeading.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
        lblHeading.autoAlignAxis(toSuperviewAxis: .vertical)
        
        imgViewDivider.autoPinEdge(.top, to: .bottom, of: lblHeading, withOffset: -30)
        imgViewDivider.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        imgViewDivider.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
        
        imgViewRankDivider.autoSetDimension(.width, toSize: 8)
        
        imgViewRankDivider.autoPinEdge(.top, to: .bottom, of: imgViewDivider, withOffset: 10)
        imgViewRankDivider.autoAlignAxis(.vertical, toSameAxisOf: imgViewDivider)
        
        lblQuestionsAnsweredHeader.autoPinEdge(.top, to: .bottom, of: imgViewDivider, withOffset: 10)
        lblQuestionsAnsweredHeader.autoPinEdge(.left, to: .left, of: imgViewDivider)
        lblQuestionsAnsweredHeader.autoPinEdge(.right, to: .left, of: imgViewRankDivider)
        
        lblRabbiteerRankingHeader.autoPinEdge(.top, to: .bottom, of: imgViewDivider, withOffset: 10)
        lblRabbiteerRankingHeader.autoPinEdge(.right, to: .right, of: imgViewDivider)
        lblRabbiteerRankingHeader.autoPinEdge(.left, to: .right, of: imgViewRankDivider)
        
        lblQuestionsAnswered.autoPinEdge(.top, to: .bottom, of: lblQuestionsAnsweredHeader, withOffset: 20)
        lblQuestionsAnswered.autoPinEdge(.left, to: .left, of: lblQuestionsAnsweredHeader)
        lblQuestionsAnswered.autoPinEdge(.right, to: .right, of: lblQuestionsAnsweredHeader)
        
        lblRabbiteerRanking.autoPinEdge(.top, to: .bottom, of: lblRabbiteerRankingHeader, withOffset: 20)
        lblRabbiteerRanking.autoPinEdge(.left, to: .left, of: lblRabbiteerRankingHeader)
        lblRabbiteerRanking.autoPinEdge(.right, to: .right, of: lblRabbiteerRankingHeader)
        
        lblRabbitsRanking.autoPinEdge(.top, to: .bottom, of: lblRabbiteerRanking, withOffset: 20)
        lblRabbitsRanking.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        
        lblRank.autoSetDimension(.width, toSize: 40)
        lblRank.autoPinEdge(.top, to: .bottom, of: lblRabbitsRanking, withOffset: 10)
        lblRank.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
        
        lblRankTitle.autoSetDimension(.width, toSize: 100)
        lblRankTitle.autoPinEdge(.top, to: .bottom, of: lblRabbitsRanking, withOffset: 10)
        lblRankTitle.autoPinEdge(.left, to: .right, of: lblRank, withOffset: 10)
        
        lblLeaderQuestionsAnswered.autoPinEdge(.top, to: .bottom, of: lblRabbitsRanking, withOffset: 10)
        lblLeaderQuestionsAnswered.autoPinEdge(.left, to: .right, of: lblRankTitle)
        lblLeaderQuestionsAnswered.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: Screen.width, height: height())
    }
    
    func height() -> CGFloat {
        return
            lblHeading.intrinsicContentSize.height + 20 +
                imgViewDivider.intrinsicContentSize.height - 30 +
                lblQuestionsAnsweredHeader.intrinsicContentSize.height + 10 +
                lblQuestionsAnswered.intrinsicContentSize.height + 20 +
                lblRabbitsRanking.intrinsicContentSize.height + 20 +
                lblRank.intrinsicContentSize.height + 10
    }
}

//
//  RabbitHeaderView.swift
//  ProjectR
//
//  Created by Wesley Buck on 2017/07/27.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import UIKit
import Material

class RabbitHeaderView: UIView {
    
    weak var delegate: RabbitHeaderCellDelegate?
    
    fileprivate let lblIndividual: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.attributedText = NSAttributedString(string: "INDIVIDUAL", attributes: Style.avenirh_medium_grey_dark_center)
        label.layer.borderColor = Style.color.green.cgColor
        label.layer.borderWidth = 4.0
        label.backgroundColor = Style.color.green
        return label
    }()
    
    fileprivate let lblTeam: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.attributedText = NSAttributedString(string: "TEAM", attributes: Style.avenirh_medium_white_center)
        label.layer.borderColor = Style.color.green.cgColor
        label.layer.borderWidth = 4.0
        label.backgroundColor = Style.color.grey_dark
        return label
    }()
    
    private let lblRabbitsRanking: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.attributedText = NSAttributedString(string: "Rabbits Ranking", attributes: Style.avenirh_large_white)
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
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: Screen.width, height: RabbitHeaderView.height()))
        backgroundColor = Style.color.grey_dark
        
        addSubview(lblIndividual)
        addSubview(lblTeam)
        
        lblIndividual.isUserInteractionEnabled = true
        lblTeam.isUserInteractionEnabled = true
        
        lblIndividual.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectionChange)))
        lblTeam.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectionChange)))
        
        addSubview(lblRabbitsRanking)
        
        addSubview(lblRank)
        addSubview(lblRankTitle)
        addSubview(lblLeaderQuestionsAnswered)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = (Screen.width - 20) / 2
        
        lblIndividual.autoSetDimensions(to: CGSize(width: width, height: 40))
        lblIndividual.autoPinEdge(toSuperviewEdge: .top, withInset: 5)
        lblIndividual.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
        
        lblTeam.autoSetDimensions(to: CGSize(width: width, height: 40))
        lblTeam.autoPinEdge(toSuperviewEdge: .top, withInset: 5)
        lblTeam.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
        
        lblRabbitsRanking.autoPinEdge(.top, to: .bottom, of: lblIndividual, withOffset: 20)
        lblRabbitsRanking.autoPinEdge(.left, to: .left, of: lblIndividual)
        
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
    
    static func height() -> CGFloat {
        return 40 + 20 + //list button height 40
            NSAttributedString(string: "Rabbits Ranking", attributes: Style.avenirh_large_white).height(forWidth: Screen.width - 20) + 20 +
            NSAttributedString(string: "#", attributes: Style.avenirl_extra_small_white_center).height(forWidth: Screen.width - 20)
    }
}

extension RabbitHeaderView {
    func selectionChange() {
        if lblIndividual.backgroundColor == Style.color.green {
            lblIndividual.backgroundColor = Style.color.grey_dark
            lblIndividual.attributedText = NSAttributedString(string: "INDIVIDUAL", attributes: Style.avenirh_medium_white_center)
            lblTeam.backgroundColor = Style.color.green
            lblTeam.attributedText = NSAttributedString(string: "TEAM", attributes: Style.avenirh_medium_grey_dark_center)
            delegate?.onSelectionChange(selection: .team)
            lblRankTitle.attributedText = NSAttributedString(string: "TEAM", attributes: Style.avenirl_extra_small_white)
        } else {
            lblIndividual.backgroundColor = Style.color.green
            lblIndividual.attributedText = NSAttributedString(string: "INDIVIDUAL", attributes: Style.avenirh_medium_grey_dark_center)
            lblTeam.backgroundColor = Style.color.grey_dark
            lblTeam.attributedText = NSAttributedString(string: "TEAM", attributes: Style.avenirh_medium_white_center)
            delegate?.onSelectionChange(selection: .individual)
            lblRankTitle.attributedText = NSAttributedString(string: "RABBIT", attributes: Style.avenirl_extra_small_white)
        }
    }
    
    func setCurrentSelection(selection: Selection) {
        if selection == Selection.individual {
            lblIndividual.backgroundColor = Style.color.green
            lblIndividual.attributedText = NSAttributedString(string: "INDIVIDUAL", attributes: Style.avenirh_medium_grey_dark_center)
            lblTeam.backgroundColor = Style.color.grey_dark
            lblTeam.attributedText = NSAttributedString(string: "TEAM", attributes: Style.avenirh_medium_white_center)
            lblRankTitle.attributedText = NSAttributedString(string: "RABBIT", attributes: Style.avenirl_extra_small_white)
        } else {
            lblIndividual.backgroundColor = Style.color.grey_dark
            lblIndividual.attributedText = NSAttributedString(string: "INDIVIDUAL", attributes: Style.avenirh_medium_white_center)
            lblTeam.backgroundColor = Style.color.green
            lblTeam.attributedText = NSAttributedString(string: "TEAM", attributes: Style.avenirh_medium_grey_dark_center)
            lblRankTitle.attributedText = NSAttributedString(string: "TEAM", attributes: Style.avenirl_extra_small_white)
        }
    }
}

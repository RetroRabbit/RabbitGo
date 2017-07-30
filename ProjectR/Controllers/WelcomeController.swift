//
//  WelcomeController.swift
//  ProjectR
//
//  Created by Hugo Meiring on 2017/07/21.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import Foundation
import UIKit
import PureLayout
import Material

class WelcomeController: UIViewController {
    /* UI */
    fileprivate let scrollView = UIScrollView()
    fileprivate let contentView = UIView()
    
    fileprivate let lblMainHead: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Welcome\nto Rabbitania", attributes: Style.avenirh_extra_large_white)
        label.textColor = Material.Color.white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    fileprivate var imgViewDivider: UIImageView = {
        let view = UIImageView(image: UIImage(named: "textfield_line"))
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()

    fileprivate let lblBody: UILabel = {
        let label = UILabel()
        let str = "For your quest today, scan as many QR codes as you can find! Each QR code unlocks a new rabbit, but don’t be fooled, as this is not the rabbit’s final form! Answer their questions too & discover all the great secrets of Rabbitania!\n\nYou may ask any Rabbit for the answers to the questions, but you’ll have to enter their unique Rabbit- codes to submit & verify your answers!"
        label.attributedText = NSAttributedString(string: str, attributes: Style.avenirl_small_white)
        label.textColor = Material.Color.white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    fileprivate let lblStatesHead: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "RABBIT QUESTION STATES:", attributes: Style.avenirh_medium_white)
        label.textColor = Material.Color.white
        return label
    }()
    
    fileprivate let lblLocked: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Locked", attributes: Style.avenirl_extra_small_white)
        label.textColor = Material.Color.white
        return label
    }()
    
    fileprivate let lblUnlocked: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Unlocked", attributes: Style.avenirl_extra_small_white)
        label.textColor = Material.Color.white
        return label
    }()
    
    fileprivate let lblAnswered: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Answered", attributes: Style.avenirl_extra_small_white)
        label.textColor = Material.Color.white
        return label
    }()
    
    fileprivate var imgLocked: UIImageView = {
        let view = UIImageView(image: UIImage(named: "image_square_grey"))
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    fileprivate var imgUnlocked: UIImageView = {
        let view = UIImageView(image: UIImage(named: "image_square_white"))
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    fileprivate var imgAnswered: UIImageView = {
        let view = UIImageView(image: UIImage(named: "image_square_green"))
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    fileprivate let lblSubImageText: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "The one who answers all the\nquestions first, WINS!", attributes: Style.avenirl_small_white_center)
        label.textColor = Material.Color.white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    fileprivate let lblGoodLuck: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "GOOD LUCK!", attributes: Style.rhino_big_green_center)
        return label
    }()
    
    internal let nextButton:ProjectRNext = ProjectRNext()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = Style.color.grey_dark

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.addSubview(lblMainHead)
        scrollView.addSubview(imgViewDivider)
        scrollView.addSubview(lblBody)
        scrollView.addSubview(lblStatesHead)
        scrollView.addSubview(lblLocked)
        scrollView.addSubview(lblUnlocked)
        scrollView.addSubview(lblAnswered)
        scrollView.addSubview(imgLocked)
        scrollView.addSubview(imgUnlocked)
        scrollView.addSubview(imgAnswered)
        scrollView.addSubview(lblSubImageText)
        scrollView.addSubview(lblGoodLuck)
        scrollView.addSubview(nextButton)
        
        nextButton.addTarget(self, action: #selector(onNext), for: UIControlEvents.touchUpInside)
        
        rabbitProfilePic(rabbitCode: "thcr072").getData(maxSize: 1 * 1024 * 1024, completion: { [weak self] (data, error) in
            guard let this = self else { return }
            if let _ = error {
                
            } else {
                let image = UIImageView(image: UIImage(data: data!))
                image.contentMode = .scaleAspectFit
                image.clipsToBounds = true
                this.imgAnswered.addSubview(image)
                this.imgAnswered.bringSubview(toFront: image)
                image.autoPinEdge(toSuperviewEdge: .top, withInset: 5)
                image.autoPinEdge(toSuperviewEdge: .bottom, withInset: 5)
                image.autoPinEdge(toSuperviewEdge: .left, withInset: 5)
                image.autoPinEdge(toSuperviewEdge: .right, withInset: 5)
            }
        })
        
        rabbitProfilePic(rabbitCode: "thcr072_line").getData(maxSize: 1 * 1024 * 1024, completion: { [weak self] (data, error) in
            guard let this = self else { return }
            if let _ = error {
                
            } else {
                let image = UIImageView(image: UIImage(data: data!))
                image.contentMode = .scaleAspectFit
                image.clipsToBounds = true
                this.imgUnlocked.addSubview(image)
                this.imgUnlocked.bringSubview(toFront: image)
                image.autoPinEdge(toSuperviewEdge: .top, withInset: 5)
                image.autoPinEdge(toSuperviewEdge: .bottom, withInset: 5)
                image.autoPinEdge(toSuperviewEdge: .left, withInset: 5)
                image.autoPinEdge(toSuperviewEdge: .right, withInset: 5)
            }
        })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let margin = Style.padding.xxl
        
        scrollView.autoPinEdgesToSuperviewEdges()
        
        lblMainHead.frame = CGRect(x: margin, y: margin, width: Screen.width, height: lblMainHead.intrinsicContentSize.height)
        
        imgViewDivider.frame = CGRect(x: margin, y: margin + lblMainHead.height / 2, width: imgViewDivider.frame.width, height: imgViewDivider.frame.height)
        
        lblBody.preferredMaxLayoutWidth = Screen.width - margin * 2
        lblBody.frame = CGRect(x: margin, y: lblMainHead.frame.bottom + margin, width: lblBody.intrinsicContentSize.width, height: lblBody.intrinsicContentSize.height)
        
        lblStatesHead.frame = CGRect(x: margin, y: lblBody.frame.bottom + margin * 2, width: Screen.width, height: lblStatesHead.intrinsicContentSize.height)
        
        let width = (Screen.width - (28.0 * 2) - 8)/3
        let imgTopPadding = lblStatesHead.frame.bottom + margin * 2
        let imgTextPosition = lblStatesHead.frame.bottom + margin
        
        imgLocked.frame = CGRect(x: 28, y: imgTopPadding, width: width, height: width)
        imgUnlocked.frame = CGRect(x: imgLocked.frame.right + 4, y: imgTopPadding, width: width, height: width)
        imgAnswered.frame = CGRect(x: imgUnlocked.frame.right + 4, y: imgTopPadding, width: width, height: width)
        
        lblLocked.frame = CGRect(x: 28 + ((width - lblLocked.intrinsicContentSize.width)/2), y: imgTextPosition, width: lblLocked.intrinsicContentSize.width, height: lblLocked.intrinsicContentSize.height)
        lblUnlocked.frame = CGRect(x: imgUnlocked.frame.left + ((width - lblUnlocked.intrinsicContentSize.width)/2), y: imgTextPosition, width: lblUnlocked.intrinsicContentSize.width, height: lblUnlocked.intrinsicContentSize.height)
        lblAnswered.frame = CGRect(x: imgAnswered.frame.left + ((width - lblAnswered.intrinsicContentSize.width)/2), y: imgTextPosition, width: lblAnswered.intrinsicContentSize.width, height: lblAnswered.intrinsicContentSize.height)
        
        lblSubImageText.frame = CGRect(x: 0, y: imgLocked.frame.bottom + margin, width: Screen.width, height: lblSubImageText.intrinsicContentSize.height)
        lblGoodLuck.frame = CGRect(x: 0, y: lblSubImageText.frame.bottom + margin, width: Screen.width, height: lblGoodLuck.intrinsicContentSize.height)
        
        nextButton.frame = CGRect(x: (Screen.width - Style.button_width)/2, y: lblGoodLuck.frame.bottom + 30, width: Style.button_width, height: Style.button_height)
        
        scrollView.contentSize = CGSize(width: Screen.width, height: nextButton.frame.bottom + 30)
    }
    
    func onNext() {
        (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = TabNavigationController()
    }
}




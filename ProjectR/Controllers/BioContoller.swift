//
//  BioContoller.swift
//  ProjectR
//
//  Created by Wesley Buck on 2017/07/29.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import UIKit
import Material

class BioController: UIViewNavigationController {
    fileprivate let scrollView = UIScrollView(forAutoLayout: ())
    
    fileprivate var celeb: Celebrity?
    
    /*UI*/
    fileprivate let lblHeading: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let imgViewDivider = UIImageView(image: UIImage(named: "textfield_line"))
    
    fileprivate let lblBio: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    init(celebrityCode: String) {
        super.init()
        celeb = firebaseCelebrities.first(where: { object -> Bool in return object.code == celebrityCode })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Style.color.grey_dark
        
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        scrollView.addSubview(lblHeading)
        scrollView.addSubview(imgViewDivider)
        scrollView.addSubview(lblBio)
        
        lblHeading.attributedText = NSAttributedString(string: "About \(celeb?.displayName ?? "")", attributes: Style.avenirh_extra_large_white)
        
        let bio: NSMutableAttributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: celeb?.bio ?? "", attributes: Style.avenirl_small_white))
        
        bio.append(NSAttributedString(string: "\n\n Category: ", attributes: Style.avenirh_small_grey_light))
        bio.append(NSAttributedString(string: celeb?.Category ?? "", attributes: Style.avenirl_small_white))
        bio.append(NSAttributedString(string: "\n Abilities: ", attributes: Style.avenirh_small_grey_light))
        bio.append(NSAttributedString(string: celeb?.Abilities ?? "", attributes: Style.avenirl_small_white))
        bio.append(NSAttributedString(string: "\n Weaknesses: ", attributes: Style.avenirh_small_grey_light))
        bio.append(NSAttributedString(string: celeb?.Weaknesses ?? "", attributes: Style.avenirl_small_white))
        
        lblBio.attributedText = bio
        
        navigationItem.title = "Rabbit Go!"
        navigationItem.titleLabel.textAlignment = .left
        navigationItem.titleLabel.textColor = Style.color.white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.autoPinEdgesToSuperviewEdges()
        
        lblHeading.autoSetDimension(.width, toSize: Style.input_width)
        lblHeading.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
        lblHeading.autoPinEdge(toSuperviewEdge: .left, withInset: Style.input_center)
        lblHeading.autoPinEdge(toSuperviewEdge: .right, withInset: Style.input_center)
        
        imgViewDivider.autoPinEdge(.top, to: .bottom, of: lblHeading, withOffset: -40)
        imgViewDivider.autoAlignAxis(toSuperviewAxis: .vertical)
        
        lblBio.autoPinEdge(.top, to: .bottom, of: imgViewDivider, withOffset: 30)
        lblBio.autoPinEdge(toSuperviewEdge: .left, withInset: Style.input_center)
        lblBio.autoPinEdge(toSuperviewEdge: .right, withInset: Style.input_center)
        lblBio.autoPinEdge(toSuperviewEdge: .bottom)
        
        scrollView.contentSize = CGSize(width: Screen.width, height: lblBio.frame.bottom + 20)
    }
}

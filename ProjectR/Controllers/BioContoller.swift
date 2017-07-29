//
//  BioContoller.swift
//  ProjectR
//
//  Created by Wesley Buck on 2017/07/29.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import UIKit

class BioController: UIViewNavigationController {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(lblHeading)
        view.addSubview(imgViewDivider)
        view.addSubview(lblBio)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        lblHeading.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
        lblHeading.autoPinEdge(toSuperviewEdge: .left, withInset: Style.input_center)
        lblHeading.autoPinEdge(toSuperviewEdge: .right, withInset: Style.input_center)
        
        imgViewDivider.autoPinEdge(.top, to: .bottom, of: lblHeading, withOffset: -40)
        imgViewDivider.autoAlignAxis(toSuperviewAxis: .vertical)
        
        lblBio.autoPinEdge(.top, to: .bottom, of: imgViewDivider, withOffset: 30)
        lblBio.autoPinEdge(toSuperviewEdge: .left, withInset: Style.input_center)
        lblBio.autoPinEdge(toSuperviewEdge: .right, withInset: Style.input_center)
        lblBio.autoPinEdge(toSuperviewEdge: .bottom)
    }
}

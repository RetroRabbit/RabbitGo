//
//  ViewNavigationController.swift
//  ProjectR
//
//  Created by Wesley Buck on 2017/07/26.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import UIKit
import Material

class UIViewNavigationController: UIViewController, ToolNavigationDelegate {
    enum NavigationHide: Int {
        case never = 0
        case toBottom = 1
        case toTop = 2
    }
    
    var hide: NavigationHide = NavigationHide.toBottom
    
    init(hiding navigationHide: NavigationHide = NavigationHide.toBottom) {
        super.init(nibName: nil, bundle: nil)
        hide = navigationHide
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareToolbar()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    open func prepareToolbar() {
    }
    
    internal func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
}

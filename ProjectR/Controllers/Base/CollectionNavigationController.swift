//
//  CollectionNavigationController.swift
//  ProjectR
//
//  Created by Wesley Buck on 2017/07/26.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import UIKit
import Material

class UICollectionNavigationController: UICollectionViewController, ToolNavigationDelegate {
    enum NavigationHide: Int {
        case never = 0
        case toBottom = 1
        case toTop = 2
    }
    
    var hide: NavigationHide = NavigationHide.toBottom
    
    init(viewLayout collectionViewLayout: UICollectionViewLayout, hiding navigationHide: NavigationHide = NavigationHide.toBottom) {
        super.init(collectionViewLayout: collectionViewLayout)
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
        //toolbar.backgroundColor = Color.blue.darken2
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if hide == NavigationHide.toBottom {
            if velocity.y > 0 {
                navigationController?.setNavigationBarHidden(true, animated: true)
                statusBarController?.statusBar.isHidden = true
            } else if velocity.y < 0 {
                navigationController?.setNavigationBarHidden(false, animated: true)
                statusBarController?.statusBar.isHidden = false
            } else if targetContentOffset.pointee.y <= 0 {
                navigationController?.setNavigationBarHidden(false, animated: true)
                statusBarController?.statusBar.isHidden = false
            }
        } else if hide == NavigationHide.toTop {
            if velocity.y < 0 {
                navigationController?.setNavigationBarHidden(true, animated: true)
                statusBarController?.statusBar.isHidden = true
            } else if velocity.y > 0 {
                navigationController?.setNavigationBarHidden(false, animated: true)
                statusBarController?.statusBar.isHidden = false
            } else if targetContentOffset.pointee.y >= scrollView.contentSize.height {
                navigationController?.setNavigationBarHidden(false, animated: true)
                statusBarController?.statusBar.isHidden = false
            }
        }
    }
    
    internal func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
}

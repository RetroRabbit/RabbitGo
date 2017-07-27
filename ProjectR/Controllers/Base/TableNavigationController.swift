//
//  UITableNavigationController.swift
//  ProjectR
//
//  Created by Wesley Buck on 2017/07/26.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import UIKit
import Material

class UITableNavigationController: UITableViewController, ToolNavigationDelegate {
    enum NavigationHide: Int {
        case never = 0
        case toBottom = 1
        case toTop = 2
    }
    
    fileprivate var hide: NavigationHide = NavigationHide.toBottom
    
    init(hiding navigationHide: NavigationHide = NavigationHide.toBottom) {
        super.init(nibName: nil, bundle: nil)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.backgroundColor = Style.color.grey_dark
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

//
//  BaseSignInController.swift
//  ProjectR
//
//  Created by Wesley Buck on 2017/07/21.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import Material
import UIKit
import Firebase

class BaseSignInController: BaseNextController {
    internal let logo: UIImageView = {
        let imgViewSplash = UIImageView(image: UIImage(named: "splash-screen"))
        imgViewSplash.contentMode = .scaleAspectFill
        return imgViewSplash
    }()
    
    internal let headingLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(logo)
        view.addSubview(headingLabel)
        
        logo.isUserInteractionEnabled = true
        logo.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(signOut))) 
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            NSLog("❌ Error signing out - \(error.localizedDescription)")
        }
        
        let ac = UIAlertController(title: "Signed out, please sign in again.", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = UINavigationController(rootViewController: SignInController())
        }))
        self.present(ac, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logo.frame = CGRect(x: (Screen.width - 112)/2, y: Style.padding.s, width: 112, height: 152)
        headingLabel.frame = CGRect(x: 40, y: logo.frame.bottom + 30, width: Screen.width - 80, height: headingLabel.intrinsicContentSize.height)
    }
}

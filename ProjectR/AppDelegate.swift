//
//  AppDelegate.swift
//  ProjectR
//
//  Created by Henko on 2017/07/09.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import Material

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    var window: UIWindow? = {
        let w = UIWindow(frame: UIScreen.main.bounds)
        w.backgroundColor = Material.Color.white
        return w
    }()
    
    var NavigationStack: UINavigationController = NavigationController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        InternalSetup()
        
        if Auth.auth().currentUser != nil {
            window?.rootViewController = TabNavigationController()
        } else {
            window?.rootViewController = UINavigationController(rootViewController: SignInController())
        }
        
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
            return GIDSignIn.sharedInstance().handle(url, sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: [:])
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url, sourceApplication: sourceApplication, annotation: annotation)
    }

    func InternalSetup() {
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self

    }
    
    func SetNavigationRoot(rootController: UIViewController) {
        window!.rootViewController = NavigationController.init(rootViewController: rootController)
        
        NavigationStack = window!.rootViewController as! NavigationController
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        
        if let error = error {
            
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                // ...
                return
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    static var rootViewController: UIViewController? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.window?.rootViewController
    }
    
    static func topViewController(_ base: UIViewController? = rootViewController) -> UIViewController {
        if  let nav = base as? UINavigationController,
            let visibleViewController = nav.visibleViewController {
            return visibleViewController
        }
        
        if  let tab = base as? UITabBarController,
            let selected = tab.selectedViewController {
            return topViewController(selected)
        }
        
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        
        return base ?? UIViewController() // crashes :(
    }
}


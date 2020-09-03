//
//  AppDelegate.swift
//  catapitest
//
//  Created by Oleg Shamin on 01.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var shortcutItemToProcess: UIApplicationShortcutItem?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let listVC = ViewControllerFactory.makeList()
        let navVC = UINavigationController(rootViewController: listVC)
        if let window = self.window {
            window.rootViewController = navVC
        } else {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = navVC
            self.window?.makeKeyAndVisible()
        }
        
        // If launchOptions contains the appropriate launch options key, a Home screen quick action
        // is responsible for launching the app. Store the action for processing once the app has
        // completed initialization.
        if let shortcutItem = launchOptions?[.shortcutItem] as? UIApplicationShortcutItem {
            shortcutItemToProcess = shortcutItem
        }
        
        return true
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        
        // Alternatively, a shortcut item may be passed in through this delegate method if the app was
        // still in memory when the Home screen quick action was used. Again, store it for processing.
        shortcutItemToProcess = shortcutItem
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
        // Is there a shortcut item that has not yet been processed?
        if let shortcutItem = shortcutItemToProcess {
            
            if shortcutItem.type == "oo.catapitest.randomaction" {
                DispatchQueue.main.async {
                    
                    if let navVC = self.window?.rootViewController as? UINavigationController,
                        let listVC = navVC.viewControllers.first as? ListViewController {
                        listVC.showRandomImage()
                    }
                }
            }
            
            shortcutItemToProcess = nil
        }
    }
}

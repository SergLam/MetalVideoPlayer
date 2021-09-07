//
//  AppDelegate.swift
//  metal-player
//
//  Created by Serg Liamthev on 10/19/19.
//  Copyright © 2019 serglam. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = StartViewController()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        return true
    }

}


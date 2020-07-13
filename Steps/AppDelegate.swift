//
//  AppDelegate.swift
//  Steps
//
//  Created by Corey Morello on 7/13/20.
//  Copyright © 2020 Corey Morello. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        window?.backgroundColor = UIColor.cyan
        let provider = StepsProvider()
        let stepsController = StepListTableViewController(provider: provider)
        let navController = UINavigationController(rootViewController: stepsController)
        navController.navigationBar.prefersLargeTitles = true

        window?.rootViewController = navController
        window?.makeKeyAndVisible()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

}


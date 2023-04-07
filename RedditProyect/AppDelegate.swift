//
//  AppDelegate.swift
//  RedditProyect
//
//  Created by Vanesa Korbenfeld on 07/04/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let newsViewController = NewsViewController()
        let principalNavigationController = UINavigationController(rootViewController: newsViewController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = principalNavigationController
        window?.makeKeyAndVisible()
        return true
    }
}


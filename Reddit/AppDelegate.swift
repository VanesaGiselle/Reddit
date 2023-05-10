//
//  AppDelegate.swift
//  Reddit
//
//  Created by Vanesa Korbenfeld on 07/04/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

//        Root: News
//        let rootViewController = NewsViewController()

//        Root: Weather
        let rootViewController = WeatherViewController()
        
        let principalNavigationController = UINavigationController(rootViewController: rootViewController)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = principalNavigationController
        window?.makeKeyAndVisible()
        return true
    }
}


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
        let networkingAlamofire = AlamofireNetworking()
        let networkingURLSession = URLSessionNetworking()
        let persistenceNewsProvider = NewsPersistenceProvider(newsPersistence: NewsPersistenceConfiguration())
        
        let newsProviderWithAlamofire = NetworkingNewsProvider(networking: networkingAlamofire)
        
        let newsProvider3 = CombineNetworkingPersistenceNewsProvider(networking: networkingURLSession, newsPersistence: NewsPersistenceConfiguration())
        
        //        Weather
        let weatherProvider = NetworkingWeatherProvider(networking: networkingAlamofire)
        let weatherProvider2 = NetworkingWeatherProvider(networking: networkingURLSession)
        
        //        Root: New
        //        let rootViewController = NewsViewController(newsProvider: newsProvider)
        //        let rootViewController = NewsViewController(newsProvider: newsProvider2)
        
        //        Root: Weather
        let rootViewController = WeatherViewController(weatherProvider: weatherProvider)
//        let rootViewController = WeatherViewController(weatherProvider: weatherProvider2)
        
        let principalNavigationController = UINavigationController(rootViewController: rootViewController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = principalNavigationController
        window?.makeKeyAndVisible()
        return true
    }
}


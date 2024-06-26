//
//  AppDelegate.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 08/05/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var coordinator: AppCoordinatorProtocol?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let appCoordinator = AppCoordinator(window: window)
        self.coordinator = appCoordinator
        appCoordinator.start()
        
        return true
    }
}

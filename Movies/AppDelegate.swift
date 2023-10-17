//
//  AppDelegate.swift
//  Movies
//
//  Created by Андрей Коноплев on 13.10.2023.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        coordinator = AppCoordinator(window: window!)
        coordinator?.start()
        return true
    }

}


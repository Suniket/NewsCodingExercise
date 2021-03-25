//
//  AppDelegate.swift
//  NewsCodingExercise
//
//  Created by Suniket Wagh on 24/3/21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let viewController = MainViewController.instantiate(fromStoryboardNamed: "MainViewController")
        window?.rootViewController = UINavigationController(rootViewController: viewController)
        
        window?.makeKeyAndVisible()
        return true
    }

}


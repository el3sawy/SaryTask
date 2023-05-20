//
//  AppDelegate.swift
//  SaryTask
//
//  Created by Ahmed Naguib on 18/05/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_
                     application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        let rootView = MainConfigurator.getViewController(with: .home)
        window?.rootViewController = UINavigationController(rootViewController: rootView)
        window?.makeKeyAndVisible()
        return true
    }
}


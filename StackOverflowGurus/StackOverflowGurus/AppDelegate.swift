//
//  AppDelegate.swift
//  StackOverflowGurus
//
//  Created by Suman Chatterjee on 07/10/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    static func makeNavigationController(_ viewModel: HomeViewModelUseCase = HomeViewModel()) -> CustomNavigationController {
        let viewModel = HomeViewModel()
        let navController = CustomNavigationController(rootViewController: HomeViewController(viewModel: viewModel))
        return navController

    }
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    private var applicationCoordinator: Coordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let navController = CustomNavigationController.makeNavigationController()
        navController.navigationBar.barTintColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        let applicationCoordinator = ApplicationCoordinator(window: window, navController: navController)
        self.window = window
        self.applicationCoordinator = applicationCoordinator
        applicationCoordinator.start()
        return true
    }

    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


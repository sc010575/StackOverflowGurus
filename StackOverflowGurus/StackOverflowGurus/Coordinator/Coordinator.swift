//
//  Coordinator.swift
//  StackOverflowGurus
//
//  Created by Suman Chatterjee on 10/10/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator {
    func start()
}

class ApplicationCoordinator: Coordinator {
    private let window: UIWindow
    private let navigationController: CustomNavigationController

    init(window: UIWindow,navController:CustomNavigationController) {
        self.window = window
        self.navigationController = navController
        self.navigationController.navigationBar.prefersLargeTitles = true
    }
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

}

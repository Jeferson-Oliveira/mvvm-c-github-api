//
//  SceneDelegate.swift
//  MVVMGithub
//
//  Created by Jeferson de Jesus on 22/08/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let navController = UINavigationController()
        let coordinator = GithubUsersCoordinator(on: navController)
        window?.rootViewController = navController
        coordinator.start()
        window?.makeKeyAndVisible()
    }
}


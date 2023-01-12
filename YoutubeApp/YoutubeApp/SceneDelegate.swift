//
//  SceneDelegate.swift
//  YoutubeApp
//
//  Created by Patrick on 12.01.2023..
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene: UIWindowScene = (scene as? UIWindowScene) else {return}
        let navigationController = UINavigationController()
        let viewController = ViewController()

        navigationController.viewControllers = [viewController]

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}


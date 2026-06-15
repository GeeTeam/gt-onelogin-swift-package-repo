//
//  SceneDelegate.swift
//  OneLoginExample-Swift
//
//  Created by GeeTest on 2026/6/15.
//  Copyright © 2026 com.geetest. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }

        let window = UIWindow(windowScene: windowScene)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        window.rootViewController = storyboard.instantiateInitialViewController() ?? UIViewController()
        self.window = window
        window.makeKeyAndVisible()
    }

}

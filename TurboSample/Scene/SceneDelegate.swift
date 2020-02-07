//
//  SceneDelegate.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-06.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
 
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else { preconditionFailure("App setup is incorrect, better crash than sorry") }
        let launcher = SceneLauncher<AccountingViewController>(scene: scene)
        launcher.launch(with: .navigation(AccountingNavigationController.self)) { window in
            self.window = window
        }
    }
}

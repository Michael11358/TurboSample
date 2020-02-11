//
//  SceneLauncher.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-07.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import UIKit

/// Sets root view controller of a window retrieved from provided scene
final class SceneLauncher<ViewController: UIViewController> {
    
    private let scene: UIWindowScene
    
    init(scene: UIWindowScene) {
        self.scene = scene
    }
    
    func launch(with option: Option?, completion: (_ window: UIWindow) -> Void) {
        let window = UIWindow(windowScene: scene)
        let viewController: UIViewController
        switch option {
        case .navigation(let type):
            viewController = type.init(rootViewController: ViewController.init())
        default:
            viewController = ViewController.init()
        }
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        completion(window)
    }
    
    enum Option {
        case navigation(UINavigationController.Type)
    }
}
 

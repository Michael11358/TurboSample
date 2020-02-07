//
//  UIViewController.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-07.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import UIKit

extension UIViewController {
    func add(child: UIViewController, to container: UIView) {
        addChild(child)
        container.addSubview(child.view)
        child.view.pin(to: container)
        child.didMove(toParent: self)
    }
}

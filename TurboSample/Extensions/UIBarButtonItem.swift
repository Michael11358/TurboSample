//
//  UIBarButtonItem.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-07.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    static func gear(target: NSObject, action: Selector) -> UIBarButtonItem {
        return UIBarButtonItem(image: UIImage(systemName: "gear"),
                               style: .plain,
                               target: target,
                               action: action)
    }
}

//
//  UIAlertController.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-11.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func error(message: String, handler: (() -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: "Oops...", message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .default) { _ in
            handler?()
        }
        alert.addAction(okay)
        return alert
    }
}

//
//  UIView.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-07.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import UIKit

extension UIView {
    func pin(to view: UIView, with insets: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left),
                                     trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insets.right),
                                     topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
                                     bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom)])
    }
}

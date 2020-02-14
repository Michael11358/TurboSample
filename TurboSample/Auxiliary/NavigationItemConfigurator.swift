//
//  NavigationItemConfigurator.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-07.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import UIKit

/// Use this convinient class to style and configure your viewController's navigationItem.
final class NavigationItemConfigurator {
    
    private let item: UINavigationItem
    
    init(item: UINavigationItem) {
        self.item = item
    }
    
    enum Side {
        case left, right
    }
    
    @discardableResult
    func set(button: UIBarButtonItem, side: Side) -> Self {
        switch side {
        case .right:
            item.rightBarButtonItem = button
        case .left:
            item.leftBarButtonItem = button
        }
        return self
    }
    
    @discardableResult
    func set(title: String) -> Self {
        item.title = title
        return self
    }
    
    @discardableResult
    func set(backButtonTitle: String) -> Self {
        item.backBarButtonItem = .init(title: backButtonTitle, style: .plain, target: nil, action: nil)
        return self
    }
}

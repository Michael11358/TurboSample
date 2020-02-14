//
//  AccountingCoordinator.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-13.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import UIKit

final class AccountingCoordinator {
    
    weak var navigation: UINavigationController?
    
    init(navigation: UINavigationController?) {
        self.navigation = navigation
    }
    
    func didLogout() {
        navigation?.present(LoginNavigationController(), animated: true, completion: { [weak navigation] in
            navigation?.popViewController(animated: false)
        })
    }
    
    func didThrowError(message: String) {
        navigation?.present(UIAlertController.error(message: message), animated: true)
    }
    
    func didLogin() {
        navigation?.present(LoginNavigationController(), animated: true, completion: nil)
    }
}

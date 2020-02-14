//
//  AccountingCoordinator.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-13.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import UIKit

final class AccountingCoordinator {
    
    let navigation: UINavigationController
    
    init?(navigation: UINavigationController?) {
        guard let navigation = navigation else { return nil }
        self.navigation = navigation
    }
    
    func didLogout() {
        navigation.present(LoginNavigationController(), animated: true, completion: { [weak navigation] in
            navigation?.popViewController(animated: false)
        })
    }
    
    func didThrowError(message: String) {
        navigation.present(UIAlertController.error(message: message), animated: true)
    }
    
    func didLogin() {
        navigation.present(LoginNavigationController(), animated: true, completion: nil)
    }
    
    func didPressSettings(currency: String, events: SettingsViewController.Events) {
        let viewController = SettingsViewController(currency: currency, events: events)
        navigation.pushViewController(viewController, animated: true)
    }
}

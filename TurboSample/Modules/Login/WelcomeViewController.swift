//
//  WelcomeViewController.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-10.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import UIKit

final class WelcomeViewController: UIViewController {
    
    @IBAction private func didPressButton(_ sender: UIButton) {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
}

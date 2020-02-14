//
//  LoginViewController.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-11.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: Properties
    private let keyboardObserver = KeyboardObserver()
    
    // MARK: IBOutlets
    @IBOutlet private var loginButton: UIButton!
    @IBOutlet private var accessoryLabel: UILabel!
    @IBOutlet private var textField: UITextField!
    @IBOutlet private var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.isEnabled = false
        loginButton.backgroundColor = .lightGray
        
        keyboardObserver.keyboardWillHideHandler = { [weak scrollView] in
            scrollView?.contentInset.bottom = 0
        }
        
        keyboardObserver.keyboardWillShowHandler = {  [weak scrollView] height in
            scrollView?.contentInset.bottom = height + 20
        }
    }
 
    // MARK: IBActions
    @IBAction private func didPressLoginButton(_ sender: UIButton) {
        guard let text = textField.text, !text.isEmptyAndNoSpace else { return }
        
        AuthenticationController.shared.authenticalte(name: text) { [weak self] success in
            if success {
                self?.dismiss(animated: true, completion: nil)
            } else {
                self?.present(UIAlertController.error(message: "Couldn't login"), animated: true, completion: nil)
            }
        }
    }
    
    @IBAction private func editingChanged(_ sender: UITextField) {
        if let text = textField.text, !text.isEmptyAndNoSpace {
            accessoryLabel.text = ""
            loginButton.isEnabled = true
            loginButton.backgroundColor = .black
        } else {
            accessoryLabel.text = "*"
            loginButton.isEnabled = false
            loginButton.backgroundColor = .lightGray
        }
    }
}

// MARK: - String Extension
private extension String {
    var isEmptyAndNoSpace: Bool {
        return trimmingCharacters(in: .whitespaces).isEmpty
    }
}

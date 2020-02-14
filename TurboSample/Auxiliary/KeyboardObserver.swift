//
//  KeyboardObserver.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-11.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import UIKit

/// Use this class to subscribe to system keyboard notifications.
final class KeyboardObserver: NSObject {
    
    var keyboardWillShowHandler: ((_ height: CGFloat) -> Void)?
    var keyboardWillHideHandler: (() -> Void)?
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        let info = notification.userInfo
        let value = info?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        let size = value?.cgRectValue
        let height = size?.height ?? 0
        keyboardWillShowHandler?(height)
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
         keyboardWillHideHandler?()
    }
}

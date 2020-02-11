//
//  UserObserver.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-11.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import Foundation

final class UserObserver {
    
    private var reference: Any?
    private let authenticationController: AuthenticationController
    
    init(authenticationController: AuthenticationController = .shared) {
        self.authenticationController = authenticationController
    }
    
    deinit {
        reference = nil
    }
    
    func observe(_ handler: @escaping (User?) -> Void) {
        reference = authenticationController.observe(\.user, options: [.initial, .new]) { object, change in
            handler(object.user)
        }
    }
}

//
//  AuthenticationController.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-11.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import Foundation

/// NOTE: this is a pseudo auth mechanism.
final class AuthenticationController: NSObject {
    
    static let shared = AuthenticationController()
    
    private let fileManagerController: FileManagerController
    
    @objc dynamic var user: User?
    
    init(fileManagerController: FileManagerController = .init()) {
        self.fileManagerController = fileManagerController
        super.init()
        fileManagerController.read(path: "token") { result in
            let user: User?
            if case let .success(data) = result {
                user = DataDecoder().decode(data: data)
            } else {
                user = nil
            }
            self.user = user
        }
    }
    
    func authenticalte(name: String, completion: @escaping (_ success: Bool) -> Void) {
        let user = User(name: name)
        if let data = DataEncoder().encode(model: user) {
            fileManagerController.clearAll()
            fileManagerController.write(data: data, path: "token")
            self.user = user
            completion(true)
        } else {
            completion(false)
        }
    }
    
    func logout() {
        fileManagerController.clearAll()
        user = nil
    }
}

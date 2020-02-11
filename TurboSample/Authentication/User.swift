//
//  User.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-11.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import Foundation

final class User: NSObject, Codable {
    
    // used as token
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

//
//  AccountingUserInputDataModel.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-09.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import Foundation

struct AccountingUserInputDataModel: Codable {
    
    var entries: [Entry]
    
    struct Entry: Codable {
        
        let value: Int
        let index: Index
        
        struct Index: Codable {
            let tab: Int
            let section: Int
            let row: Int
        }
    }
}

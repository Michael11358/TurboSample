//
//  AccountingTableDefinitionDataModel.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-08.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import Foundation

struct AccountingTableDefinitionDataModel: Codable {
    
    let version: String
    let tabs: [Tab]
    
    struct Tab: Codable {
        let title: String
        let sections: [Section]
        
        struct Section: Codable {
            let title: String
            let rows: [String]
        }
    }
}

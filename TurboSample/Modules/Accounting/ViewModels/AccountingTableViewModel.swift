//
//  AccountingTableViewModel.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-09.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import Foundation

struct AccountingTableViewModel {
    
    var sections: [SectionViewModel]
    
    struct SectionViewModel {
        let title: String
        var rows: [RowViewModel]
    }
    
    struct RowViewModel {
        var text: String?
        let title: String
        let placeholder: String
    }
}

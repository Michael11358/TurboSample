//
//  AccountingDataController.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-07.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import UIKit

final class AccountingDataController {
    
    let service = AccountingService()
    
    var viewModels = [AccountingTabViewModel]()
    var userInput = [Index: String?]()
    
    
    var setupHandler: (([AccountingTabViewModel]) -> Void)?
    var updateHandler: (([AccountingTabViewModel]) -> Void)?
    
    func load() {
        service.load(endpoint: .definitions, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(model):
                 
                let viewModels: [AccountingTabViewModel] = model.tabs.map {
                    AccountingTabViewModel(title: $0.title, sections: $0.sections.map {
                        AccountingTableSectionViewModel(title: $0.title, rows: $0.rows.map {
                            AccountingTableTextFieldViewModel(text: nil, title: $0, placeholder: "$0000")
                        })
                         
                    })
                }
                self.viewModels = viewModels
                self.setupHandler?(viewModels)
            case .failure:
                break
            }
        })
    }
    
    func didEndEditingInput(text: String?, at index: Index) {
        userInput[index] = text
        viewModels[index.tab].sections[index.indexPath.section].rows[index.indexPath.row].text = text
        updateHandler?(viewModels)
    }
    
    
    struct Index: Hashable {
        let tab: Int
        let indexPath: IndexPath
    }
}

 
 

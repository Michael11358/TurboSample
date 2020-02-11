//
//  AccountingDataTransformer.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-10.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import Foundation

struct AccountingDataTransformer {
    /// Coverts definition of the table dataModel retrieved from API to viewModels that can be
    /// perceived by the tableView
    static func viewModel(from dataModel: AccountingTableDefinitionDataModel) -> AccountingViewModel {
        let viewModels = dataModel.tabs.map {
            AccountingTabViewModel(title: $0.title, sections: $0.sections.map {
                AccountingTableSectionViewModel(title: $0.title, rows: $0.rows.map {
                    AccountingTableTextFieldViewModel(text: nil, title: $0, placeholder: "$0000")
                })
            })
        }
        return AccountingViewModel(summaries: [], tabs: viewModels)
    }
}

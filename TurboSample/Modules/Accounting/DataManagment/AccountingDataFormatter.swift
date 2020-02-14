//
//  AccountingDataFormatter.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-10.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import Foundation

/// Converts API models to UI models
struct AccountingDataFormatter {
    
    static func tabs(from dataModel: AccountingTableDefinitionDataModel) -> AccountingTabsViewModel {
        let tabs = dataModel.tabs.map { tab in
            AccountingTabsViewModel.TabViewModel(title: tab.title)
        }
        return AccountingTabsViewModel(viewModels: tabs)
    }
    
    static func tables(from dataModel: AccountingTableDefinitionDataModel) -> [Int: AccountingTableViewModel] {
        let assets = dataModel.tabs.item(at: 0)?.sections.map { section in
            AccountingTableViewModel.SectionViewModel(title: section.title, rows: section.rows.map { row in
                AccountingTableViewModel.RowViewModel(text: nil, title: row, placeholder: "$0000")
            })
        } ?? []
        
        let liabilities = dataModel.tabs.item(at: 1)?.sections.map { section in
            AccountingTableViewModel.SectionViewModel(title: section.title, rows: section.rows.map { row in
                AccountingTableViewModel.RowViewModel(text: nil, title: row, placeholder: "$0000")
            })
        } ?? []
        return [0: .init(sections: assets), 1: .init(sections: liabilities)]
    }
    
    static func summaries(assets: Int, liabilities: Int) -> AccountingSummariesViewModel {
        let summaries: [AccountingSummariesViewModel.SummaryViewModel]
        summaries = [.init(text: "Assets: $\(assets)", height: 44, color: .gray),
                     .init(text: "Liabilities: $\(liabilities)", height: 44, color: .darkGray),
                     .init(text: "Net Worth: $\(assets - liabilities)", height: 50, color: .turboDarkGreen)]
        return AccountingSummariesViewModel(viewModels: summaries)
    }
}

// MARK: Array Extension
private extension Array {
    func item(at index: Int) -> Element? {
        guard indices.contains(index) else { return nil }
        return self[index]
    }
}

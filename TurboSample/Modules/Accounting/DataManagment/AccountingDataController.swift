//
//  AccountingDataController.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-07.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import UIKit

final class AccountingDataController {
    
    // MARK: Properties
    private let service = AccountingService()
    private(set) var viewModel: AccountingViewModel?
    private var tableDefinitionDataModel: AccountingTableDefinitionDataModel?
    private lazy var userInputDataModelController = AccountingUserInputDataModelController()
     
    var setupHandler  : ((AccountingViewModel) -> Void)?
    var updateHandler : ((AccountingViewModel) -> Void)?
 
    // MARK: Public
    func load() {
        service.load(completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(dataModel):
                self.tableDefinitionDataModel = dataModel
                var viewModel = AccountingDataTransformer.viewModel(from: dataModel)
                self.userInputDataModelController.laod(version: dataModel.version) { userInputDataModel in
                    
                    userInputDataModel?.entries.forEach {
                        viewModel.tabs[$0.index.tab].sections[$0.index.section].rows[$0.index.row].text = "\($0.value)"
                    }
                    
                    let assets = self.userInputDataModelController.assets
                    let liabilities = self.userInputDataModelController.liabilities
                    viewModel.summaries = [.init(text: "Assets: $\(assets)", height: 44, color: .gray),
                                           .init(text: "Liabilities: $\(liabilities)", height: 44, color: .darkGray),
                                           .init(text: "Net Worth: $\(assets - liabilities)", height: 44, color: .turboDarkGreen)]
                    
                    self.viewModel = viewModel
                    self.setupHandler?(viewModel)
                }
            case .failure:
                // TODO: handle error
                break
            }
        })
    }
    
    func didEndEditingInput(text: String, tab: Int, section: Int, row: Int) {
        guard var viewModel = viewModel, let tableDefinitionDataModel = tableDefinitionDataModel else { return }
        let value = Int(text) ?? 0
        viewModel.tabs[tab].sections[section].rows[row].text = text
        userInputDataModelController.update(value: value,
                                            index: .init(tab: tab, section: section, row: row),
                                            version: tableDefinitionDataModel.version)
        let assets = self.userInputDataModelController.assets
        let liabilities = self.userInputDataModelController.liabilities
        viewModel.summaries[0].text = "Assets: $\(assets)"
        viewModel.summaries[1].text = "Liabilities: $\(liabilities)"
        viewModel.summaries[2].text = "Net Worth: $\(assets - liabilities)"
        self.viewModel = viewModel
        updateHandler?(viewModel) 
    }
}

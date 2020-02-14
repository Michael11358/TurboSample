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
    private let service : AccountingService
    private let cache   : Cache
    private let events  : Events
 
    private lazy var userInputDataModelController = AccountingUserInputDataModelController()
    
    // MARK: Initializations
    init(events: Events, service: AccountingService = .init()) {
        self.events = events
        self.service = service
        self.cache = .init()
    }
    
    // MARK: Public
    func load() {
        events.stateUpdateHandler(.loading)
        service.load(completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(dataModel):
                self.cache.tableDefinitionDataModel = dataModel
                self.userInputDataModelController.laod(version: dataModel.version) { userInputDataModel in
                    var tables = AccountingDataFormatter.tables(from: dataModel)
                    userInputDataModel?.entries.forEach {
                        tables[$0.index.tab]?.sections[$0.index.section].rows[$0.index.row].text = "\($0.value)"
                    }
                    let assets = self.userInputDataModelController.assets
                    let liabilities = self.userInputDataModelController.liabilities
                    let summaries = AccountingDataFormatter.summaries(assets: assets, liabilities: liabilities)
                    let tabs = AccountingDataFormatter.tabs(from: dataModel)
                    self.events.summariesUpdateHandler(summaries)
                    self.events.tabsUpdateHandler(tabs)
                    self.cache.tables = tables
                    if let table = tables[0] {
                        self.events.tableUpdateHandler(table, true)
                    }
                    self.events.stateUpdateHandler(.normal)
                }
            case .failure:
                self.events.stateUpdateHandler(.normal)
                self.events.errorUpdateHandler("Couldn't retrieve data")
            }
        })
    }
    
    func didEndEditingInput(text: String, tab: Int, section: Int, row: Int) {
        guard var table = cache.tables[tab], let tableDefinitionDataModel = cache.tableDefinitionDataModel else { return }
        let value = Int(text) ?? 0
        table.sections[section].rows[row].text = text
        userInputDataModelController.update(value: value,
                                            index: .init(tab: tab, section: section, row: row),
                                            version: tableDefinitionDataModel.version)
        let assets = self.userInputDataModelController.assets
        let liabilities = self.userInputDataModelController.liabilities
        let summaries = AccountingDataFormatter.summaries(assets: assets, liabilities: liabilities)
        self.cache.tables[tab] = table
        self.events.tableUpdateHandler(table, false)
        self.events.summariesUpdateHandler(summaries)
    }
    
    func didSelect(tab: Int) {
        guard let table = cache.tables[tab] else { return }
        self.events.tableUpdateHandler(table, true)
    }
}

// MARK: Auxiliary
extension AccountingDataController {
    
    final class Events {
        let summariesUpdateHandler : ((_ viewModel: AccountingSummariesViewModel) -> Void)
        let tableUpdateHandler     : ((_ viewModel: AccountingTableViewModel, _ reload: Bool) -> Void)
        let tabsUpdateHandler      : ((_ viewModel: AccountingTabsViewModel) -> Void)
        let errorUpdateHandler     : ((_ message: String) -> Void)
        let stateUpdateHandler     : ((_ state: State) -> Void)
        
        init(summariesUpdateHandler: @escaping ((AccountingSummariesViewModel) -> Void),
             tableUpdateHandler: @escaping ((AccountingTableViewModel, Bool) -> Void),
             tabsUpdateHandler: @escaping ((AccountingTabsViewModel) -> Void),
             errorUpdateHandler: @escaping ((String) -> Void),
             stateUpdateHandler: @escaping ((_ state: State) -> Void)) {
            self.summariesUpdateHandler = summariesUpdateHandler
            self.tableUpdateHandler = tableUpdateHandler
            self.tabsUpdateHandler = tabsUpdateHandler
            self.errorUpdateHandler = errorUpdateHandler
            self.stateUpdateHandler = stateUpdateHandler
        }
    }
    
    private final class Cache {
        var tables = [Int: AccountingTableViewModel]()
        var tableDefinitionDataModel: AccountingTableDefinitionDataModel?
    }
    
    enum State {
        case normal
        case loading
    }
}

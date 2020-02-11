//
//  AccountingUserInputDataModelController.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-10.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import Foundation

final class AccountingUserInputDataModelController {
    
    private var userInputDataModel: AccountingUserInputDataModel?
    private let fileManagerController = FileManagerController()
    
    var assets: Int {
        guard let userInputDataModel = userInputDataModel else { return 0 }
        return userInputDataModel.entries.filter { $0.index.tab == 0 }.reduce(0, {
            $0 + $1.value
        })
    }
    
    var liabilities: Int {
        guard let userInputDataModel = userInputDataModel else { return 0 }
        return userInputDataModel.entries.filter { $0.index.tab == 1 }.reduce(0, {
            $0 + $1.value
        })
    }
    
    func laod(version: String, completion: @escaping (AccountingUserInputDataModel?) -> Void) {
        fileManagerController.read(path: "\(version)userInput.json") { result in
            let dataModel: AccountingUserInputDataModel?
            switch result {
            case let .success(data):
                dataModel = DataDecoder().decode(data: data)
            case .failure:
                dataModel = nil
            }
            self.userInputDataModel = dataModel
            completion(dataModel)
        }
    }

    func update(value: Int, index: Index, version: String) {
        var model: AccountingUserInputDataModel
        if let userInputDataModel = self.userInputDataModel {
            model = userInputDataModel
        } else {
            model = AccountingUserInputDataModel(entries: [])
        }
        if let firstIndex = model.entries.firstIndex(where: { $0.index == index }) {
            model.entries[firstIndex] = .init(value: value, index: index)
        } else {
            model.entries.append(.init(value: value, index: index))
        }
        if let data = DataEncoder().encode(model: model) {
            fileManagerController.write(data: data, path: "\(version)userInput.json")
        }
        self.userInputDataModel = model
    }

    struct Index: Hashable {
        let tab: Int
        let section: Int
        let row: Int
    }
}
 
// MARK: - Array Extension
private extension Array where Element == AccountingUserInputDataModel.Entry {
    var dictionary: [AccountingUserInputDataModelController.Index: Int] {
        reduce(into: [:]) {
            $0[AccountingUserInputDataModelController.Index(tab: $1.index.tab,
                                                            section: $1.index.section,
                                                            row: $1.index.row)] = $1.value
        }
    }
}

// MARK: - AccountingUserInputDataModel.Entry.Index Extension
private extension AccountingUserInputDataModel.Entry.Index {
    static func == (lhs: Self, rhs: AccountingUserInputDataModelController.Index) -> Bool {
        return lhs.row == rhs.row && lhs.section == rhs.section && lhs.tab == rhs.tab
    }
}

// MARK: - AccountingUserInputDataModel.Entry Extension
private extension AccountingUserInputDataModel.Entry {
    init(value: Int, index: AccountingUserInputDataModelController.Index) {
        self.value = value
        self.index = .init(tab: index.tab, section: index.section, row: index.row)
    }
}

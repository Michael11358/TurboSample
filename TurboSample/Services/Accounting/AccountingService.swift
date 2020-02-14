//
//  AccountingService.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-09.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import Foundation

final class AccountingService {
 
    func load(completion: @escaping (Result<AccountingTableDefinitionDataModel>) -> Void) {
        guard let url = EndPoint.definition.request else {
            completion(.failure)
            return
        }
        DataModelLoader<AccountingTableDefinitionDataModel>().load(request: url) { result in
            switch result {
            case let .success(model):
                completion(.success(model))
            case .failure:
                completion(.failure)
            }
        }
    }
}

// MARK: - Auxiliary
extension AccountingService {
    
    enum Result<T> {
        case success(T)
        case failure
    }
    
    enum EndPoint {
        
        case definition
        
        var request: URLRequest? {
            // temporary json hoster
            guard let url = URLBuilder(scheme: .https, host: "api.myjson.com", path: "/bins/18i6d8").build() else {
                return nil
            }
            return URLRequestBuilder(url: url, method: .get, headers: [:]).build()
        }
    }
}

//
//  DataModelLoader.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-09.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import Foundation

final class DataModelLoader<Model: Decodable> {
    
    private let performer: URLRequestPerformer
    
    init(performer: URLRequestPerformer = .init()) {
        self.performer = performer
    }
    
    func load(request: URLRequest, completion: @escaping (Result<Model, Error>) -> Void) {
        performer.perform(request: request) { result in
            switch result {
            case .success(let data):
                if let model: Model = DataDecoder().decode(data: data) {
                    completion(.success(model))
                } else {
                    completion(.failure(.decode))
                }
            case .failure(let error):
                switch error {
                case let .server(code):
                    completion(.failure(.server(code: code)))
                default:
                    completion(.failure(.unknown))
                }
            }
        }
    }
    
    enum Error: Swift.Error {
        case decode
        case server(code: Int)
        case unknown
    }
}

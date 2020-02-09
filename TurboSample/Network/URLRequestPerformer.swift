//
//  URLRequestPerformer.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-09.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import Foundation

final class URLRequestPerformer {
    
    private let session: URLSession
 
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func perform(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        let task = session.dataTask(with: request) { data, response, error in
            let result: Result<Data, Error>
            switch (data, response, error) {
            case let (data?, response as HTTPURLResponse, nil):
                // TODO: Good idea to refactor
                let code = response.statusCode
                if (200 ... 299).contains(code) {
                    result = .success(data)
                } else {
                    result = .failure(.server(code: code))
                }
            case let (_, _, error?):
                // TODO: Good idea to refactor
                if let cache = URLCache.shared.cachedResponse(for: request) {
                    result = .success(cache.data)
                } else {
                    result = .failure(.client(error: error))
                }
            default:
                result = .failure(.unknown)
            }
            DispatchQueue.main.async { completion(result) }
        }
        task.resume()
    }
    
    enum Error: Swift.Error {
        case client(error: Swift.Error)
        case server(code: Int)
        case unknown
    }
}

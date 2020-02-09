//
//  URLRequestBuilder.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-09.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import Foundation

struct URLRequestBuilder {
    
    private let request: URLRequest
    
    init(url: URL, method: Method, headers: [String: String]) {
        var request = URLRequest(url: url)
        headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        self.request = request
    }
 
    func build() -> URLRequest {
        return request
    }
    
    enum Method: String {
        case get  = "GET"
        case post = "POST"
    }
}

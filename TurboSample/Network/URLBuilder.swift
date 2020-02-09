//
//  URLBuilder.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-09.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import Foundation

struct URLBuilder {
    
    private let components: URLComponents
    
    init(scheme: Scheme, host: String, path: String) {
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.host = host
        components.path = path
        self.components = components
    }
    
    func build() -> URL? {
        return components.url
    }
    
    enum Scheme: String {
        case http
        case https
    }
}

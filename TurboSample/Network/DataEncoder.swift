//
//  DataEncoder.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-10.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import Foundation

struct DataEncoder {
    
    private let encoder: JSONEncoder
    
    init(encoder: JSONEncoder = .init()) {
        self.encoder = encoder
    }
    
    func encode<T: Encodable>(model: T) -> Data? {
        return try? encoder.encode(model)
    }
}

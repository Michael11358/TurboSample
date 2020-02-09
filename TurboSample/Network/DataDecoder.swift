//
//  DataDecoder.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-09.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import Foundation

struct DataDecoder {
    
    private let decoder: JSONDecoder
    
    init(decoder: JSONDecoder = .init()) {
        self.decoder = decoder
    }
    
    func decode<T: Decodable>(data: Data) -> T? {
        return try? decoder.decode(T.self, from: data)
    }
}

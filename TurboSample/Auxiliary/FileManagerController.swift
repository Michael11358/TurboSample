//
//  FileManagerController.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-10.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import Foundation

final class FileManagerController {
    
    private let fileManager: FileManager
    
    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
    }
    
    func write(data: Data, path: String, completion: ((_ success: Bool) -> Void)? = nil) {
        guard let url = fileManager.fileUrl(atPath: path) else {
            completion?(false)
            return
        }
        do {
            try data.write(to: url, options: .atomic)
            completion?(true)
        } catch {
            completion?(false)
        }
    }
    
    func read(path: String, completion: @escaping (Result<Data>) -> Void) {
        guard let url = fileManager.fileUrl(atPath: path) else {
            completion(.failure)
            return
        }
        do {
            let data = try Data(contentsOf: url)
            completion(.success(data))
        } catch {
            completion(.failure)
        }
    }
    
    func clearAll() {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsUrl,
                                                                       includingPropertiesForKeys: nil,
                                                                       options: [.skipsHiddenFiles, .skipsSubdirectoryDescendants])
            for fileURL in fileURLs {
                try FileManager.default.removeItem(at: fileURL)
            }
        } catch  { print(error) }
    }
    
    enum Result<T> {
        case success(T)
        case failure
    }
}

private extension FileManager {
    func fileUrl(atPath path: String) -> URL? {
        guard var url = urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        url = url.appendingPathComponent(path)
        return url
    }
  
}

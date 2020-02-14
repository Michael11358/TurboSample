//
//  FileManagerController.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-10.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import Foundation

final class FileManagerController {
    
    // MARK: Properties
    private let fileManager: FileManager
    
    // MARK: Initialization
    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
    }
    
    // MARK: Public
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
        guard let directory = fileManager.documentDirectory else { return }
        guard let urls = try? fileManager.contentsOfDirectory(at: directory,
                                                                  includingPropertiesForKeys: nil,
                                                                  options: [.skipsHiddenFiles, .skipsSubdirectoryDescendants]) else { return }
        urls.forEach { try? fileManager.removeItem(at: $0) }
    }
}

// MARK: - Auxiliary
extension FileManagerController {
    enum Result<T> {
        case success(T)
        case failure
    }
}

// MARK: - FileManager Extension
private extension FileManager {
    func fileUrl(atPath path: String) -> URL? {
        guard var directory = documentDirectory else { return nil }
        directory = directory.appendingPathComponent(path)
        return directory
    }
    
    var documentDirectory: URL? {
        return urls(for: .documentDirectory, in: .userDomainMask).first
    }
}

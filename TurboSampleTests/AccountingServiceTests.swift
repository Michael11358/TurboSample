//
//  AccountingServiceTests.swift
//  TurboSampleTests
//
//  Created by Voline, Michael on 2020-02-13.
//  Copyright © 2020 MihaVoline. All rights reserved.
//


import XCTest
@testable import TurboSample

class AccountingServiceTests: XCTestCase {
    
    var subject: AccountingService!
    
    func testServiceSuccess() {
        let session = URLSessionMock(type: .success)
        let object = AccountingTableDefinitionDataModel(version: "1", tabs: [])
        session.data = try! JSONEncoder().encode(object)
        session.response = HTTPURLResponse(url: URL(string: "http://")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let performer = URLRequestPerformer(session: session)
        let loader = AccountingService.ModelLoader(performer: performer)
        subject = AccountingService(modelLoader: loader)
        let expectation = XCTestExpectation()
        subject.load { result in
            if case .failure = result {
                XCTFail("")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testServiceFail() {
        let session = URLSessionMock(type: .failure)
        let cache = URLCache(memoryCapacity: 0, diskCapacity: 0)
        cache.removeAllCachedResponses()
        let performer = URLRequestPerformer(session: session, cache: cache)
        let loader = AccountingService.ModelLoader(performer: performer)
        subject = AccountingService(modelLoader: loader)
        let expectation = XCTestExpectation()
        subject.load { result in
            if case .success = result {
                XCTFail("")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}

 

class URLSessionMock: URLSessionProtocol {
    
    let type: MockType
    
    var data: Data?
    var response: HTTPURLResponse?
    
    init(type: MockType) {
        self.type = type
    }
    
    enum MockType {
        case failure
        case success
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return URLSessionDataTaskMock(completion: { [unowned self] in
            switch self.type {
            case .success:
                completionHandler(self.data, self.response, nil)
            case .failure:
                completionHandler(nil, nil, NSError(domain: "tests", code: 101, userInfo: nil))
            }
        })
    }
}

class URLSessionDataTaskMock: URLSessionDataTask {
  
    private let completion: () -> Void
    
    init(completion: @escaping () -> Void) {
        self.completion = completion
    }

    override func resume() {
        completion()
    }
}

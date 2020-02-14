//
//  TurboSampleTests.swift
//  TurboSampleTests
//
//  Created by Voline, Michael on 2020-02-06.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import XCTest
@testable import TurboSample

class AccountingCoordinatorTests: XCTestCase {
    
    var subject: AccountingCoordinator!
    
    func testCoordination() {
        let navigation = UINavigationController()
        
        subject = AccountingCoordinator(navigation: navigation)
       
        subject.didPressSettings(currency: "test", events: SettingsViewController.Events(logoutHandler: {
            
        }, currencyChangeHandler: { _ in
        
        }))
        
        XCTAssertTrue(navigation.topViewController!.isKind(of: SettingsViewController.self))
    }
}

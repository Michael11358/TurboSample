//
//  AccountingViewController.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-06.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import UIKit

final class AccountingViewController: UIViewController {
    
    // MARK: IBOutleta
    @IBOutlet private var segmentedControl   : UISegmentedControl!
    @IBOutlet private var stackViewContainer : UIView!
    @IBOutlet private var tableViewContainer : UIView!
     
    // MARK: Properties
    private lazy var stackViewController = AccountingSummaryStackViewController()
    private lazy var tableViewController = AccountingTableViewController()

    // MARK: Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationItemConfigurator(item: navigationItem)
            .set(button: .settings(target: self, action: #selector(didPressSettingsButton)), side: .right)
            .set(title: "Yp, Michael")
        
        add(child: stackViewController, to: stackViewContainer)
        add(child: tableViewController, to: tableViewContainer)
        
        stackViewController.insert(viewModel: .init(text: "adksaok", height: 50, color: .turboDarkGreen), at: 0)
    }
    
    // MARK: Actions
    @objc private func didPressSettingsButton(_ sender: UIBarButtonItem) {
        
    }

    // MARK: IBActions
    @IBAction private func didChangeSegmentedControl(_ sender: UISegmentedControl) {
        
    }
}

// MARK: - UIBarButtonItem
private extension UIBarButtonItem {
    static func settings(target: UIViewController, action: Selector) -> UIBarButtonItem {
        let button = UIBarButtonItem.gear(target: target, action: action)
        button.tintColor = .black
        return button
    }
}

//
//  AccountingViewController.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-06.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import UIKit
 
final class AccountingViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet private var stackViewContainer: UIView!
    @IBOutlet private var tableViewContainer: UIView!
    @IBOutlet private var tabsContainer: UIView!
    
    // MARK: Properties
    private lazy var stackViewController = AccountingSummaryStackViewController()
    private lazy var tableViewController = AccountingTableViewController()
    private lazy var tabsViewController = AccountingTabsController()
    private lazy var dataController = AccountingDataController()

    // MARK: Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NavigationItemConfigurator(item: navigationItem)
            .set(button: .settings(target: self, action: #selector(didPressSettingsButton)), side: .right)
            .set(title: "Yp, Michael")
        
        add(child: stackViewController, to: stackViewContainer)
        add(child: tableViewController, to: tableViewContainer)
        add(child: tabsViewController, to: tabsContainer)
        
        dataController.load()
        
        dataController.setupHandler = { [weak self] viewModels in
            guard let self = self else { return }
            self.tabsViewController.set(tabs: viewModels.map { $0.title })
            self.tableViewController.viewModels = viewModels[0].sections
            self.tableViewController.tableView.reloadData()
        }
         
        dataController.updateHandler = { [weak self] viewModels in
            guard let self = self else { return }
            let tab = self.tabsViewController.selected
            self.tableViewController.viewModels = viewModels[tab].sections
        }
        
        tabsViewController.selectionHandler = { index in
            self.tableViewController.viewModels = self.dataController.viewModels[index].sections
            self.tableViewController.tableView.reloadData()
        }
        
        tableViewController.editingDidEndHandler = { [weak self] indexPath, text in
            guard let self = self else { return }
            let tab = self.tabsViewController.selected
            self.dataController.didEndEditingInput(text: text, at: .init(tab: tab, indexPath: indexPath))
        }
        
        stackViewController.insert(viewModel: .init(text: "adksaok", height: 50, color: .turboDarkGreen), at: 0)
        tableViewController.tableView.contentInset.bottom = 70
    }
    
    // MARK: Actions
    @objc private func didPressSettingsButton(_ sender: UIBarButtonItem) {
        
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

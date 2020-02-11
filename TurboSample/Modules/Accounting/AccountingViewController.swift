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
    private lazy var tabsViewController = AccountingTabsViewController()
    private lazy var dataController = AccountingDataController()
    private lazy var userObserver = UserObserver()

    // MARK: Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NavigationItemConfigurator(item: navigationItem)
            .set(button: .settings(target: self, action: #selector(didPressSettingsButton)), side: .right)
            .set(backButtonTitle: "")
        
        add(child: stackViewController, to: stackViewContainer)
        add(child: tableViewController, to: tableViewContainer)
        add(child: tabsViewController, to: tabsContainer)
        
        dataController.load()
        
        dataController.setupHandler = { [weak self] viewModel in
            guard let self = self else { return }
            self.tabsViewController.set(tabs: viewModel.tabs.map { $0.title })
            self.tableViewController.set(viewModels: viewModel.tabs[0].sections, reloadTable: true)
            
            for (index, viewModel) in viewModel.summaries.enumerated() {
                self.stackViewController.insert(viewModel: viewModel, at: index)
                self.tableViewController.tableView.contentInset.bottom += viewModel.height + 6
            }
        }
         
        dataController.updateHandler = { [weak self] viewModel in
            guard let self = self else { return }
            let tab = self.tabsViewController.selected
            self.tableViewController.set(viewModels: viewModel.tabs[tab].sections, reloadTable: false)
            
            for (index, viewModel) in viewModel.summaries.enumerated() {
                self.stackViewController.set(text: viewModel.text, at: index)
            }
        }
        
        tabsViewController.selectionHandler = { [weak self] index in
            guard let self = self, let viewModels = self.dataController.viewModel?.tabs[index].sections else { return }
            self.tableViewController.set(viewModels: viewModels, reloadTable: true)
        }
        
        tableViewController.editingDidEndHandler = { [weak self] indexPath, text in
            guard let self = self, let text = text else { return }
            let tab = self.tabsViewController.selected
            self.dataController.didEndEditingInput(text: text,tab: tab,section: indexPath.section, row: indexPath.row )
        }
        
        userObserver.observe { [weak self] user in
            guard let self = self else { return }
            if let user = user {
                self.title = "Hello, \(user.name)"
            } else {
                self.title = ""
                
            }
        }
        
        if AuthenticationController.shared.user == nil {
            self.present(LoginNavigationController(), animated: true, completion: nil)
        }
    }
    
    // MARK: Actions
    @objc private func didPressSettingsButton(_ sender: UIBarButtonItem) {
        sender.isEnabled = false
        let currency = UserDefaults.standard.string(forKey: "currency") ?? "CAD"
        let viewController = SettingsViewController(currency: currency)
        viewController.logoutHandler = { [weak self] in
            guard let self = self else { return }
            AuthenticationController.shared.logout()
            self.present(LoginNavigationController(), animated: true, completion: {
                self.navigationController?.popViewController(animated: false)
            })
        }
        viewController.currencyChangeHandler = { currency in
            UserDefaults.standard.set(currency, forKey: "currency")
        }
        navigationController?.pushViewController(viewController, animated: true)
        sender.isEnabled = true
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

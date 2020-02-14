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
    @IBOutlet private var summariesViewContainer : UIView!
    @IBOutlet private var tableViewContainer     : UIView!
    @IBOutlet private var tabsContainer          : UIView!
    @IBOutlet private var activityIndicator      : UIActivityIndicatorView!
    
    // MARK: Properties
    private lazy var summariesViewController = AccountingSummariesViewController()
    private lazy var tableViewController = AccountingTableViewController()
    private lazy var tabsViewController = AccountingTabsViewController()
    private lazy var userObserver = UserObserver()
    private lazy var dataController: AccountingDataController = {
        let events = AccountingDataController.Events(summariesUpdateHandler: { [weak self] summaries in
            self?.summariesViewController.set(summaries: summaries)
            self?.tableViewController.set(bottomInset: summaries.height + 20)
            }, tableUpdateHandler: { [weak tableViewController] table, reload in
                tableViewController?.set(viewModel: table, reloadTable: reload)
            }, tabsUpdateHandler: { [weak tabsViewController] tabs in
                tabsViewController?.set(tabs: tabs.viewModels.map { $0.title })
            }, errorUpdateHandler: { [weak self] message in
                self?.present(UIAlertController.error(message: message), animated: true)
            }, stateUpdateHandler: { [weak activityIndicator] state in
                switch state {
                case .normal:
                    activityIndicator?.stopAnimating()
                case .loading:
                    activityIndicator?.startAnimating()
                }
            }
        )
        return AccountingDataController(events: events)
    }()
    
    // MARK: Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NavigationItemConfigurator(item: navigationItem)
            .set(button: .settings(target: self, action: #selector(didPressSettingsButton)), side: .right)
            .set(backButtonTitle: "")
        
        add(child: summariesViewController, to: summariesViewContainer)
        add(child: tableViewController, to: tableViewContainer)
        add(child: tabsViewController, to: tabsContainer)
       
       
        tabsViewController.selectionHandler = { [weak dataController] index in
            dataController?.didSelect(tab: index)
        }

        tableViewController.editingDidEndHandler = { [weak self] indexPath, text in
            guard let self = self, let text = text else { return }
            let tab = self.tabsViewController.selected
            self.dataController.didEndEditingInput(text: text,tab: tab,section: indexPath.section, row: indexPath.row )
        }
        
        userObserver.observe { [weak self] user in
            guard let self = self else { return }
            if let user = user {
                self.dataController.load()
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
            AuthenticationController.shared.logout()
            self?.present(LoginNavigationController(), animated: true, completion: {
                self?.navigationController?.popViewController(animated: false)
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

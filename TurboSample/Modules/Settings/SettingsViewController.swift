//
//  SettingsViewController.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-11.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import UIKit

final class SettingsViewController: UITableViewController {
    
    // MARK: Properties
    private let events: Events
    private var currency: String
    
    // MARK: Initialization
    init(currency: String, events: Events) {
        self.currency = currency
        self.events = events
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        preconditionFailure()
    }
    
    // MARK: Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        tableView.separatorStyle = .none
        tableView.register(.SettingsButtonCell, forCellReuseIdentifier: "buttonCell")
        tableView.register(.SettingsPickerCell, forCellReuseIdentifier: "pickerCell")
    }
    
    // MARK: DataSource and Delegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return tableView.pickerCell(indexPath: indexPath, viewModel: .init(title: "Select Currency", input: currency))
        } else {
            return tableView.buttonCell(indexPath: indexPath) { [weak events] in
                events?.logoutHandler()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let data = ["CAD", "USD"]
            let picker = PickerViewController(data: data)
            picker.selectionHandler = { [weak self] index in
                guard let self = self else { return }
                self.currency = data[index]
                self.tableView.reloadData()
                self.events.currencyChangeHandler(self.currency)
            }
            present(picker, animated: true, completion: nil)
        }
    }
}

extension SettingsViewController {
    
    final class Events {
        
        let logoutHandler: (() -> Void)
        let currencyChangeHandler: ((String) -> Void)
        
        init(logoutHandler: @escaping (() -> Void), currencyChangeHandler: @escaping ((String) -> Void)) {
            self.logoutHandler = logoutHandler
            self.currencyChangeHandler = currencyChangeHandler
        }
    }
    
}

// MARK: - UITableView Extension
private extension UITableView {
    func buttonCell(indexPath: IndexPath, handler: @escaping () -> Void) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: "buttonCell", for: indexPath)
        if let cell = cell as? SettingsButtonCell {
            cell.set(viewModel: .init(titleColor: .red, backgroundColor: .white, title: "Logout"))
            cell.buttonPressHandler = { _ in
                handler()
            }
        }
        return cell
    }
    
    func pickerCell(indexPath: IndexPath, viewModel: SettingsPickerViewModel) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: "pickerCell", for: indexPath)
        if let cell = cell as? SettingsPickerCell {
            cell.set(viewModel: viewModel)
        }
        return cell
    }
}

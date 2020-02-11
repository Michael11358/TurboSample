//
//  AccountingTableViewController.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-07.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import UIKit

final class AccountingTableViewController: UITableViewController {
    
    // MARK: Properties
    var editingDidEndHandler: ((_ indexPath: IndexPath, _ text: String?) -> Void)?
    
    private (set) var viewModels = [AccountingTableSectionViewModel]()
    
    // MARK: Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        tableView.register(.AccountingTableTextFieldCell, forCellReuseIdentifier: "textFieldCell")
        tableView.register(.AccountingTableSectionHeaderView, forHeaderFooterViewReuseIdentifier: "headerView")
    }
    
    // MARK: Public
    func set(viewModels: [AccountingTableSectionViewModel], reloadTable: Bool) {
        self.viewModels = viewModels
        if reloadTable {
            tableView.reloadData()
        }
    }
    
    // MARK: DataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModels.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels[section].rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "textFieldCell", for: indexPath)
        if let cell = cell as? AccountingTableTextFieldCell {
            cell.set(viewModel: viewModels[indexPath.section].rows[indexPath.row])
            cell.editingDidEndHandler = { [weak self] cell, text in
                guard let self = self else { return }
                guard let indexPath = self.tableView.indexPath(for: cell) else { return }
                self.editingDidEndHandler?(indexPath, text)
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerView")
        if let view = view as? AccountingTableSectionHeaderView {
            view.set(title: viewModels[section].title)
        }
        return view
    }
}

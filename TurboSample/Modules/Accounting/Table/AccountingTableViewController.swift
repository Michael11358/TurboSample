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
    
    private var viewModel = AccountingTableViewModel(sections: [])

    // MARK: Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        tableView.register(.AccountingTableTextFieldCell, forCellReuseIdentifier: "textFieldCell")
        tableView.register(.AccountingTableSectionHeaderView, forHeaderFooterViewReuseIdentifier: "headerView")
    }
    
    // MARK: Public
    func set(viewModel: AccountingTableViewModel, reloadTable: Bool) {
        self.viewModel = viewModel
        if reloadTable { tableView.reloadData() }
    }
    
    func set(bottomInset: CGFloat) {
        tableView.contentInset.bottom = bottomInset
    }
}

// MARK: DataSource and Delegate
extension AccountingTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections[section].rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "textFieldCell", for: indexPath)
        if let cell = cell as? AccountingTableTextFieldCell {
            cell.set(viewModel: viewModel.sections[indexPath.section].rows[indexPath.row])
            cell.editingDidEndHandler = { [weak self] cell, text in
                guard let indexPath = self?.tableView.indexPath(for: cell) else { return }
                self?.editingDidEndHandler?(indexPath, text)
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerView")
        if let view = view as? AccountingTableSectionHeaderView {
            view.set(title: viewModel.sections[section].title)
        }
        return view
    }
}

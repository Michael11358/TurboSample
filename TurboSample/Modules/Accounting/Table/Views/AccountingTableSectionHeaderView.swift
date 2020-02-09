//
//  AccountingTableSectionHeaderView.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-07.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import UIKit

final class AccountingTableSectionHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet private var titleLabel: UILabel!
    
    func set(title: String) {
        titleLabel.text = title
    }
}

// MARK: - UINib Extension
extension UINib {
    static var AccountingTableSectionHeaderView: UINib {
        UINib(nibName: "AccountingTableSectionHeaderView", bundle: .main)
    }
}

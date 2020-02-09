//
//  AccountingTableTextFieldCell.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-07.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import UIKit

final class AccountingTableTextFieldCell: UITableViewCell {
    
    var editingDidEndHandler: ((_ cell: UITableViewCell, _ text: String?) -> Void)?
    
    // MARK: IBOutlets
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var textField: UITextField!
    
    // MARK: Setup
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.layer.cornerRadius = 4
        textField.addTarget(self, action: #selector(editingDidEnd), for: .editingChanged)
    }
    
    // MARK: Public
    func set(viewModel: AccountingTableTextFieldViewModel) {
        titleLabel.text = viewModel.title
        textField.text = viewModel.text
        textField.placeholder = viewModel.placeholder
    }
    
    @objc func editingDidEnd(_ sender: UITextField) {
        editingDidEndHandler?(self, sender.text)
    }
}

// MARK: - UINib Extension
extension UINib {
    static var AccountingTableTextFieldCell: UINib {
        UINib(nibName: "AccountingTableTextFieldCell", bundle: .main)
    }
}

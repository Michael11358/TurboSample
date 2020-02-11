//
//  SettingsPickerCell.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-11.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import UIKit

final class SettingsPickerCell: UITableViewCell {

    @IBOutlet private var inputLabel: UILabel!
    @IBOutlet private var titleLabel: UILabel!
    
    func set(viewModel: SettingsPickerViewModel) {
        titleLabel.text = viewModel.title
        inputLabel.text = viewModel.input
    }
}

// MARK: - UINib Extension
extension UINib {
    static var SettingsPickerCell: UINib {
        UINib(nibName: "SettingsPickerCell", bundle: .main)
    }
}


struct SettingsPickerViewModel {
    let title: String
    let input: String
}

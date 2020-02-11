//
//  SettingsButtonCell.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-11.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import UIKit

final class SettingsButtonCell: UITableViewCell {
    
    var buttonPressHandler: ((_ cell: UITableViewCell) -> Void)?
    
    @IBOutlet private var button: UIButton!
    
    // MARK: Public
    func set(viewModel: SettingsButtonViewModel) {
        button.backgroundColor = viewModel.backgroundColor
        button.setTitleColor(viewModel.titleColor, for: .normal)
        button.setTitle(viewModel.title, for: .normal)
    }
    
    @IBAction private func didPressButton(_ sender: UIButton) {
        buttonPressHandler?(self)
      }
}

// MARK: - UINib Extension
extension UINib {
    static var SettingsButtonCell: UINib {
        UINib(nibName: "SettingsButtonCell", bundle: .main)
    }
}

struct SettingsButtonViewModel {
    let titleColor: UIColor
    let backgroundColor: UIColor
    let title: String
}

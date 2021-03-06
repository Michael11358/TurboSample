//
//  AccountingSummaryView.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-07.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import UIKit

final class AccountingSummaryView: UIView {
   
    // MARK: Properties
    private let label: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.minimumScaleFactor = 0.6
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    // MARK: Initialization
    init(viewModel: AccountingSummariesViewModel.SummaryViewModel) {
        super.init(frame: .zero)
        backgroundColor = viewModel.color
        addSubview(label)
        label.pin(to: self, with: .init(top: 0, left: 16, bottom: 0, right: 16))
        label.text = viewModel.text
        heightAnchor.constraint(equalToConstant: viewModel.height).isActive = true
    }
    
    required init?(coder: NSCoder) {
        preconditionFailure()
    }
    
    // MARK: Public
    func set(text: String) {
        label.text = text
    }
}

//
//  AccountingSummariesViewController.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-07.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import UIKit

final class AccountingSummariesViewController: UIViewController {
    
    // MARK: Properties
    private var views = [AccountingSummaryView]()

    // MARK: IBOutlet
    @IBOutlet private var stackView: UIStackView!
    
    // MARK: Public
    func set(text: String, at index: Int) {
        views[index].set(text: text)
    }
    
    func set(summaries: AccountingSummariesViewModel) {
        views.removeAll()
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        summaries.viewModels.forEach {
            let view = AccountingSummaryView(viewModel: $0)
            views.append(view)
            stackView.addArrangedSubview(view)
        }
    }
}

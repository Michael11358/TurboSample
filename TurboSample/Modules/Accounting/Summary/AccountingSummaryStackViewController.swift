//
//  AccountingSummaryStackViewController.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-07.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import UIKit

final class AccountingSummaryStackViewController: UIViewController {
    
    private var views = [AccountingSummaryTextView]()

    @IBOutlet private var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func set(text: String, at index: Int) {
        views[index].set(text: text)
    }
    
    func set(viewModels: [AccountingSummaryTextViewModel]) {
        views.removeAll()
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        viewModels.forEach {
            let view = AccountingSummaryTextView(viewModel: $0)
            views.append(view)
            stackView.addArrangedSubview(view)
        }
    }
}

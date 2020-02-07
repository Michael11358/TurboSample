//
//  AccountingSummaryStackViewController.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-07.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import UIKit

final class AccountingSummaryStackViewController: UIViewController {
    
    private var views = [Int: AccountingSummaryTextView]()

    @IBOutlet private var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func set(text: String, at index: Int) {
        views[index]?.set(text: text)
    }
    
    func insert(viewModel: AccountingSummaryTextViewModel, at index: Int) {
        let view = AccountingSummaryTextView(viewModel: viewModel)
        views[index] = view
        stackView.insertArrangedSubview(view, at: index)
    }
    
    func remove(at index: Int) {
        views[index]?.removeFromSuperview()
        views[index] = nil
    }
}

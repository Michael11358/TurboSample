//
//  AccountingTabsViewController.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-09.
//  Copyright © 2020 MihaVoline. All rights reserved.
//
 
import UIKit

final class AccountingTabsViewController: UIViewController {
    
    // MARK: Properties
    var selectionHandler: ((_ index: Int) -> Void)?
    
    private (set) var selected = 0
    
    // MARK: IBOutlets
    @IBOutlet private var segmentedControl: UISegmentedControl!
    
    // MARK: Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.isEnabled = false
    }
    
    // MARK: Public
    func set(tabs: [String]) {
        for (index, tabs) in tabs.enumerated() {
            segmentedControl.setTitle(tabs, forSegmentAt: index)
        }
        segmentedControl.isEnabled = true
    }
    
    // MARK: IBActions
    @IBAction private func didChangeSegmentedControl(_ sender: UISegmentedControl) {
        sender.isEnabled = false
        selected = sender.selectedSegmentIndex
        selectionHandler?(sender.selectedSegmentIndex)
        sender.isEnabled = true
    }
}

//
//  PickerViewController.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-11.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import UIKit

final class PickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
   
    // MARK: Properties
    var data = [String]() {
        didSet { pickerView?.reloadAllComponents() }
    }
    
    var selectionHandler: ((_ index: Int) -> Void)?
    
    // MARK: IBOutlets
    @IBOutlet private var pickerView: UIPickerView!
    @IBOutlet private var tappableView: UIView!
    
    // MARK: Initialization
    init(data: [String]) {
        super.init(nibName: "PickerViewController", bundle: .main)
        self.data = data
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        preconditionFailure()
    }
    
    // MARK: Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        tappableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
    }
    
    // MARK: IBActions
    @IBAction func didPressSelectButton(_ sender: UIButton) {
        sender.isEnabled = false
        selectionHandler?(pickerView.selectedRow(inComponent: 0))
        dismiss(animated: true, completion: nil)
        sender.isEnabled = true
    }
    
    @objc func didTap() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Delegate and DataSource
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
}

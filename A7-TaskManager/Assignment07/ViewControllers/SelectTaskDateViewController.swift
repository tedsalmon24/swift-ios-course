//
// Ted Salmon SelectTaskDateViewController.swift
//  Assignment07
//
//  Created by Mohamed Shehab on 2/18/25.
//

import UIKit

protocol SelectTaskDateViewControllerDelegate {
    func didSelectDate(date: Date)
}

class SelectTaskDateViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    var delegate: SelectTaskDateViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func cancelButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func submitButtonClicked(_ sender: Any) {
        self.delegate!.didSelectDate(date: datePicker.date)
        dismiss(animated: true, completion: nil)
    }
}

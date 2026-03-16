//
// Ted Salmon CreateTaskViewController.swift
//  Assignment07
//
//  Created by Mohamed Shehab on 2/18/25.
//

import UIKit

protocol CreateTaskViewControllerDelegate {
    func didCreateTask(task: Task)
}

class CreateTaskViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    var delegate: CreateTaskViewControllerDelegate?
    
    var selectedDate: Date?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("viewDidLoad called")
        print("Outlets - Name: \(String(describing: nameTextField)), Date: \(String(describing: dateLabel)), Priority: \(String(describing: prioritySegmentedControl))")
        
    }

    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func submitButtonClicked(_ sender: Any) {
        print(nameTextField.text ?? "No name")
        print(dateLabel.text ?? "No date")
        guard let name = nameTextField.text, !name.isEmpty else {
            self.alertPrompt(title: "Error", message: "Please enter a name")
            return
        }
        
        guard let date = selectedDate else {
            self.alertPrompt(title: "Error", message: "Please select a date")
            return
        }
        
        let priority = prioritySegmentedControl.selectedSegmentIndex
        let task = Task(name: name, priority: priority, date: date)
        delegate?.didCreateTask(task: task)
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GotoSelectDateSegue" {
            let selectDateVC = segue.destination as! SelectTaskDateViewController
            selectDateVC.delegate = self
        }
    }
}

extension CreateTaskViewController: SelectTaskDateViewControllerDelegate {
    func didSelectDate(date: Date) {
        selectedDate = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateLabel.text = dateFormatter.string(from: date)
    }
    // dismiss keyboard on touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

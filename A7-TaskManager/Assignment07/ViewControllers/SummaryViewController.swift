// 
//  SummaryViewController.swift
//  Assignment07
//
//  Created by Ted Salmon on 2/26/26.
//

import UIKit

protocol SummaryViewControllerDelegate: AnyObject {
    func didDeleteTask(task: Task)
}

class SummaryViewController: UIViewController {

    @IBOutlet weak var nameSummary: UILabel!
    @IBOutlet weak var prioritySummary: UILabel!
    @IBOutlet weak var dateSummary: UILabel!
    
    // Property to hold the selected task
    var selectedTask: Task?
    weak var delegate: SummaryViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Display the task details
        if let task = selectedTask {
            nameSummary.text = task.name
            
            // Format priority
            let priorities = ["Low", "Medium", "High"]
            prioritySummary.text = priorities[task.priority]
            
            // Format date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            dateSummary.text = dateFormatter.string(from: task.date)
        }
    }
    

    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func deletePressed(_ sender: Any) {
        // Show confirmation alert
        let alert = UIAlertController(
            title: "Delete Task",
            message: "Are you sure you want to delete this task?",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            guard let self = self, let task = self.selectedTask else { return }
            self.delegate?.didDeleteTask(task: task)
            self.dismiss(animated: true)
        })
        
        present(alert, animated: true)
    }
}

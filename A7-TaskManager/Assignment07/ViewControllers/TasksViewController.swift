// Ted Salmon
//  ViewController.swift
//  Assignment06
//
//  Created by Mohamed Shehab on 2/18/25.
//

import UIKit

class TasksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var tasks = [Task]()
    var sortSelection = SortSelection(sortAttribute: "date", isAscending: true)
    @IBOutlet weak var taskCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasks.append(Task(name: "ATask 1", priority: 2, date: Date()))
        tasks.append(Task(name: "BTask 1", priority: 1, date: Date()))
        tasks.append(Task(name: "CTask 1", priority: 0, date: Date()))
        
        
        let cellNib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "CustomTableViewCell")
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        updateTaskCountLabel()
    }
    
    func updateTaskCountLabel() {
        let count = tasks.count
        taskCountLabel.text = "You have \(count) task\(count == 1 ? "" : "s")."
    }
    
    @IBAction func clearAllPressed(_ sender: Any) {
        // Check if there are tasks to delete
        guard !tasks.isEmpty else {
            // Show alert that there are no tasks
            let alert = UIAlertController(
                title: "No Tasks",
                message: "There are no tasks to clear.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        // Show confirmation alert
        let alert = UIAlertController(
            title: "Clear All Tasks",
            message: "Are you sure you want to delete all \(tasks.count) task\(tasks.count == 1 ? "" : "s")? This action cannot be undone.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Clear All", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            
            // Remove all tasks
            self.tasks.removeAll()
            
            // Reload table view with animation
            self.tableView.reloadData()
            
            // Update task count label
            self.updateTaskCountLabel()
        })
        
        present(alert, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GotoCreateTaskSegue" {
            let createTaskVC = segue.destination as! CreateTaskViewController
            createTaskVC.delegate = self
        } else if segue.identifier == "GotoSelectSortSegue" {
            let sortVC = segue.destination as! SortViewController
            sortVC.delegate = self
        } else if segue.identifier == "GotoSummarySegue" {
            let summaryVC = segue.destination as! SummaryViewController
            // Pass the selected task and set delegate
            if let indexPath = tableView.indexPathForSelectedRow {
                summaryVC.selectedTask = tasks[indexPath.row]
                summaryVC.delegate = self
            }
        }
    }
}

extension TasksViewController: CreateTaskViewControllerDelegate{
    func didCreateTask(task: Task) {
        self.tasks.append(task)
        self.tableView.reloadData()
        updateTaskCountLabel()
    }
}


extension TasksViewController: SortViewControllerDelegate {
    func didSelectSort(sortSelection: SortSelection) {
        self.sortSelection = sortSelection
        sortTasks()
        tableView.reloadData()
    }
    func sortTasks() {
        switch sortSelection.sortAttribute {
        case "name":
            tasks.sort { sortSelection.isAscending ? $0.name < $1.name : $0.name > $1.name }
        case "date":
            tasks.sort { sortSelection.isAscending ? $0.date < $1.date : $0.date > $1.date }
        case "priority":
            tasks.sort { sortSelection.isAscending ? $0.priority < $1.priority : $0.priority > $1.priority }
        default:
            break
        }
    }
}

extension TasksViewController: CustomTVCellDelegate {
    func deleteIsClicked(cell: CustomTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        // Show confirmation alert
        alertPromptDestructive(
            title: "Delete Task",
            message: "Are you sure you want to delete this task?",
            okHandler: { _ in
                self.tasks.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                self.updateTaskCountLabel()
            },
            cancelHandler: { _ in }
        )
    }
}

extension TasksViewController: SummaryViewControllerDelegate {
    func didDeleteTask(task: Task) {
        // Find and remove the task
        if let index = tasks.firstIndex(where: { $0.name == task.name && $0.date == task.date && $0.priority == task.priority }) {
            tasks.remove(at: index)
            tableView.reloadData()
            updateTaskCountLabel()
        }
    }
}

extension TasksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        let task = tasks[indexPath.row]
        
        // Configure the cell
        cell.nameLabel.text = task.name
        
        // Format the date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        cell.dateLabel.text = dateFormatter.string(from: task.date)
        
        // Set priority text
        let priorities = ["Low", "Medium", "High"]
        cell.priorityLabel.text = priorities[task.priority]
        
        // Set the delegate
        cell.delegate = self
        
        return cell
    }
}
extension TasksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Trigger segue to show task details
        performSegue(withIdentifier: "GotoSummarySegue", sender: self)
    }
}


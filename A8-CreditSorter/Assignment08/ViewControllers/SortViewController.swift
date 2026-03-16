// Ted Salmon
//  SortViewController.swift
//  Assessment03
//
//  Created by Mohamed Shehab on 3/18/25.
//

import UIKit

// MARK: - Protocol Definition
/// This protocol defines what methods a delegate must implement to receive sort selections
protocol SortViewControllerDelegate: AnyObject {
    /// Called when the user selects a sort option
    /// - Parameters:
    ///   - attribute: The attribute to sort by (e.g., "Name", "Age", "Credit Score", "State")
    ///   - order: The sort order ("ASC" for ascending, "DESC" for descending)
    func didSelectSort(attribute: String, order: String)
}

class SortViewController: UIViewController {
    

    
    let sortOptions = ["Name", "Age", "Credit Score", "State"]
    
    // MARK: - Delegate Property
    /// Weak reference to prevent retain cycles (memory leaks)
    weak var delegate: SortViewControllerDelegate?
    
    /// The currently selected sort attribute (passed from UsersViewController)
    var currentSortAttribute: String = "Name"
    
    /// The currently selected sort order (passed from UsersViewController)
    var currentSortOrder: String = "ASC"
    
    // MARK: - IBOutlets
    // TODO: Connect these to your storyboard UI elements
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up table view
        tableView?.dataSource = self
        tableView?.delegate = self
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
// MARK: - UITableViewDataSource
extension SortViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Use a basic cell or create a custom one
        let cell = tableView.dequeueReusableCell(withIdentifier: "SortOptionCell") ?? UITableViewCell(style: .default, reuseIdentifier: "SortOptionCell")
        
        let option = sortOptions[indexPath.row]
        cell.textLabel?.text = option
        
        // Show a checkmark if this is the currently selected option
        if option == currentSortAttribute {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SortViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedAttribute = sortOptions[indexPath.row]
        
        // Call the delegate method to pass the selection back
        delegate?.didSelectSort(attribute: selectedAttribute, order: currentSortOrder)
        
        // Dismiss the view controller
        self.dismiss(animated: true)
    }
}


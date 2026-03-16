// Ted Salmon
//  FilterViewController.swift
//  Assessment03
//
//  Created by Mohamed Shehab on 3/18/25.
//

import UIKit

// MARK: - Protocol Definition
/// This protocol defines what methods a delegate must implement to receive filter selections
protocol FilterViewControllerDelegate: AnyObject {
    /// Called when the user selects a filter category or removes the filter
    /// - Parameter category: The selected credit category, or nil if "No Filter" was selected
    func didSelectFilter(category: CreditCategory?)
}

class FilterViewController: UIViewController {
    let creditCategories = [
        CreditCategory(name: "Excellent", iconImageName: "excellent"),
        CreditCategory(name: "Very Good", iconImageName: "very_good"),
        CreditCategory(name: "Good", iconImageName: "good"),
        CreditCategory(name: "Fair", iconImageName: "fair"),
        CreditCategory(name: "Poor", iconImageName: "poor")
    ]
    
    // MARK: - Delegate Property
    /// Weak reference to prevent retain cycles (memory leaks)
    weak var delegate: FilterViewControllerDelegate?
    
    /// The currently selected filter category (passed from UsersViewController)
    var currentFilterCategory: CreditCategory?
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up table view
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CreditTableViewCell", bundle: nil), forCellReuseIdentifier: "CreditTableViewCell")
        
        print("🔍 FilterViewController loaded with current filter: \(currentFilterCategory?.name ?? "None")")
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }

    @IBAction func noFilterClicked(_ sender: Any) {
        
        // Pass nil to indicate no filter
        delegate?.didSelectFilter(category: nil)
        
        // Dismiss the view controller
        self.dismiss(animated: true)
    }
}

// MARK: - UITableViewDataSource
extension FilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CreditTableViewCell", for: indexPath) as! CreditTableViewCell
        
        let category = creditCategories[indexPath.row]
        
        // Configure the cell with the custom outlets
        cell.creditLabel.text = category.name
        cell.creditImageView.image = UIImage(named: category.iconImageName)
        
        // Show a checkmark if this is the currently selected filter
        if let currentFilter = currentFilterCategory, currentFilter.name == category.name {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedCategory = creditCategories[indexPath.row]
        
        // Call the delegate method to pass the selection back
        delegate?.didSelectFilter(category: selectedCategory)
        
        // Dismiss the view controller
        self.dismiss(animated: true)
    }
}


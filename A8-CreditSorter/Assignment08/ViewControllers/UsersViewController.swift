// Ted Salmon
//  UsersViewController.swift
//  Assessment03
//
//  Created by Mohamed Shehab on 3/18/25.
//

import UIKit

class UsersViewController: UIViewController {
    var users = [User]()
    var allUsers = [User]()  // Keep original list for filtering
    var selectedFilterCategory: CreditCategory?
    var selectedSortAttribute: String = "Name"
    var selectedSortOrder: String = "ASC"

    @IBOutlet weak var sortedByLabel: UILabel!
    @IBOutlet weak var filteredByLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
        
        // Prepopulate with test data
        allUsers.append(User(name: "Ahmed", age: 30, creditScore: 800, state: "Colorado, CO"))
        allUsers.append(User(name: "Sarah", age: 25, creditScore: 740, state: "California, CA"))
        allUsers.append(User(name: "John", age: 45, creditScore: 300, state: "Texas, TX"))
        
        // Initialize users with all users (no filter initially)
        users = allUsers
        
        // Initialize the UI labels
        updateSortLabel()
        updateFilterLabel()
        
        // Apply initial sorting
        applySorting()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddUserSegue" {
            let nav = segue.destination as! UINavigationController
            let vc = nav.viewControllers.first as! AddUserViewController
            // when addusersegue is called, this tells the other screen that this screen is the delegate
            vc.delegate = self
            
        } else if segue.identifier == "SortSegue" {
            let nav = segue.destination as! UINavigationController
            let vc = nav.viewControllers.first as! SortViewController
            
            vc.delegate = self
            
            // Pass the current sort settings so the UI can show what's selected
            vc.currentSortAttribute = selectedSortAttribute
            vc.currentSortOrder = selectedSortOrder
            
            
        } else if segue.identifier == "FilterSegue" {
            let nav = segue.destination as! UINavigationController
            let vc = nav.viewControllers.first as! FilterViewController
            
            // IMPORTANT: Set the delegate so FilterViewController can communicate back
            vc.delegate = self
            
            // Pass the current filter setting so the UI can show what's selected
            vc.currentFilterCategory = selectedFilterCategory
            
        }
    }
    
    @IBAction func sortAscendingClicked(_ sender: Any) {
        // Update the sort order to ascending
        selectedSortOrder = "ASC"
        
        // Apply the current sort
        applySorting()
        
        // Update the UI label
        updateSortLabel()
        
    }
    
    @IBAction func sortDescendingClicked(_ sender: Any) {
        // Update the sort order to descending
        selectedSortOrder = "DESC"
        
        // Apply the current sort
        applySorting()
        
        // Update the UI label
        updateSortLabel()
        
    }
    
    // MARK: - Sorting Helper Methods
    
    /// Applies the current sort attribute and order to the users array
    private func applySorting() {
        users.sort { user1, user2 in
            var result = false
            
            // Determine comparison based on selected attribute
            switch selectedSortAttribute {
            case "Name":
                result = user1.name.lowercased() < user2.name.lowercased()
            case "Age":
                result = user1.age < user2.age
            case "Credit Score":
                result = user1.creditScore < user2.creditScore
            case "State":
                result = user1.state.lowercased() < user2.state.lowercased()
            default:
                result = user1.name.lowercased() < user2.name.lowercased()
            }
            
            // Reverse the comparison if descending
            return selectedSortOrder == "ASC" ? result : !result
        }
        
        // Refresh the table view
        tableView.reloadData()
        
    }
    
    // MARK: - Filtering Helper Methods
    
    /// Applies the current filter category to the users array
    private func applyFiltering() {
        if let filterCategory = selectedFilterCategory {
            // Get the minimum credit score for the selected category
            let minScore = getMinimumCreditScore(for: filterCategory)
            
            // Filter users based on credit score (selected category and higher)
            users = allUsers.filter { user in
                user.creditScore >= minScore
            }
            
        } else {
            // No filter - show all users
            users = allUsers
        }
        
        // After filtering, apply the current sort
        applySorting()
    }
    
    /// Returns the minimum credit score for a given category
    /// - Parameter category: The credit category
    /// - Returns: The minimum score for that category
    private func getMinimumCreditScore(for category: CreditCategory) -> Int {
        switch category.name {
        case "Excellent":
            return 800
        case "Very Good":
            return 740
        case "Good":
            return 670
        case "Fair":
            return 580
        case "Poor":
            return 300
        default:
            return 300
        }
    }
    
    /// Updates the sort label to show current settings
    private func updateSortLabel() {
        let orderText = selectedSortOrder == "ASC" ? "Ascending" : "Descending"
        sortedByLabel.text = "Sorted by: \(selectedSortAttribute) (\(orderText))"
    }
    
    /// Updates the filter label to show current filter
    private func updateFilterLabel() {
        if let filter = selectedFilterCategory {
            filteredByLabel.text = "Filtered by: \(filter.name)"
        } else {
            filteredByLabel.text = "Filtered by: None"
        }
    }
}

// MARK: - UITableViewDataSource
extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        let user = users[indexPath.row]
        
        // Configure the custom cell with user data
        cell.user = user
        cell.delegate = self
        cell.nameLabel.text = user.name
        cell.stateLabel.text = user.state
        cell.ageLabel.text = "\(user.age)"
        cell.creditLabel.text = "\(user.creditScore)"
        
        // Set credit score image based on score
        if user.creditScore >= 800 {
            cell.creditImageView.image = UIImage(named: "excellent")
        } else if user.creditScore <= 799 && user.creditScore >= 740 {
            cell.creditImageView.image = UIImage(named: "very_good")
        } else if user.creditScore <= 739 && user.creditScore >= 670 {
            cell.creditImageView.image = UIImage(named: "good")
        } else if user.creditScore <= 669 && user.creditScore >= 580 {
            cell.creditImageView.image = UIImage(named: "fair")
        } else if user.creditScore <= 579 && user.creditScore >= 300 {
            cell.creditImageView.image = UIImage(named: "poor")
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension UsersViewController: UITableViewDelegate {
    // Add any delegate methods you need here
}

// MARK: - AddUserViewControllerDelegate
extension UsersViewController: AddUserViewControllerDelegate {
    func didAddUser(_ user: User) {
        
        // Add to the master list
        allUsers.append(user)
        
        // Re-apply filtering (this will update users array and sort)
        applyFiltering()
    }
}

// MARK: - UserTableViewCellDelegate
extension UsersViewController: UserTableViewCellDelegate {
    func didTapDelete(on cell: UserTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        let userToDelete = users[indexPath.row]
        
        // Remove from the filtered users array
        users.remove(at: indexPath.row)
        
        // Also remove from the master allUsers array
        if let allUsersIndex = allUsers.firstIndex(where: { $0.name == userToDelete.name && $0.creditScore == userToDelete.creditScore }) {
            allUsers.remove(at: allUsersIndex)
        }
        
        tableView.deleteRows(at: [indexPath], with: .fade)
        
    }
}

// MARK: - SortViewControllerDelegate
extension UsersViewController: SortViewControllerDelegate {
    func didSelectSort(attribute: String, order: String) {
        
        // Update the current sort settings
        selectedSortAttribute = attribute
        selectedSortOrder = order
        
        // Apply the sorting
        applySorting()
        
        // Update the UI label
        updateSortLabel()
    }
}
// MARK: - FilterViewControllerDelegate
extension UsersViewController: FilterViewControllerDelegate {
    func didSelectFilter(category: CreditCategory?) {
        
        // Update the current filter setting
        selectedFilterCategory = category
        
        // Apply the filtering (this will also sort)
        applyFiltering()
        
        // Update the UI label
        updateFilterLabel()
    }
}


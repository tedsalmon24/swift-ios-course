
//  ViewController.swift
//  Assignment03
//  Assignent3
//  Created by Ted Salmon on 1/28/26.
//

import UIKit

class EditUserViewController: UIViewController {
    // The user being edited; ProfileViewController expects to set and read this
    var user: User?

    // Optional outlets for editing fields; keep them optional to avoid crashes if not connected
    @IBOutlet weak var nameTextField: UITextField?
    @IBOutlet weak var emailTextField: UITextField?
    @IBOutlet weak var roleSegment: UISegmentedControl?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Debug: Check if user and outlets are set
        print("DEBUG: User object: \(String(describing: user))")
        print("DEBUG: nameTextField: \(String(describing: nameTextField))")
        print("DEBUG: emailTextField: \(String(describing: emailTextField))")
        print("DEBUG: roleSegment: \(String(describing: roleSegment))")
        
        // Configure the segmented control segments FIRST
        roleSegment?.removeAllSegments()
        roleSegment?.insertSegment(withTitle: "Student", at: 0, animated: false)
        roleSegment?.insertSegment(withTitle: "Employee", at: 1, animated: false)
        roleSegment?.insertSegment(withTitle: "Other", at: 2, animated: false)
        
        // Then populate fields with existing values from the user object
        nameTextField?.text = user?.name
        emailTextField?.text = user?.email
        
        print("DEBUG: After setting - nameTextField.text: \(String(describing: nameTextField?.text))")
        print("DEBUG: After setting - emailTextField.text: \(String(describing: emailTextField?.text))")
        
        // Set the selected segment based on the user's role
        if let role = user?.role {
            // Matching the role values from CreateUserViewController: "Student", "Employee", "Other"
            switch role.lowercased() {
            case "student":
                roleSegment?.selectedSegmentIndex = 0
            case "employee":
                roleSegment?.selectedSegmentIndex = 1
            case "other":
                roleSegment?.selectedSegmentIndex = 2
            default:
                roleSegment?.selectedSegmentIndex = 0
            }
            print("DEBUG: Selected segment index: \(String(describing: roleSegment?.selectedSegmentIndex))")
        } else {
            print("DEBUG: User role is nil")
        }
        
        // Add tap gesture to dismiss keyboard when tapping outside text fields
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    // Action for a Save button; updates the user and performs unwind
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        // Get and trim input values
        let name = nameTextField?.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let email = emailTextField?.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        // Get the role from the segment control
        let selectedIndex = roleSegment?.selectedSegmentIndex ?? -1
        let role = selectedIndex >= 0 ? (roleSegment?.titleForSegment(at: selectedIndex) ?? "") : ""
        
        // Validate inputs
        if name.isEmpty {
            showAlert(title: "Missing Name", message: "Please enter a name.")
            return
        }
        if email.isEmpty {
            showAlert(title: "Missing Email", message: "Please enter an email.")
            return
        }
        if role.isEmpty {
            showAlert(title: "Missing Role", message: "Please select a role.")
            return
        }
        
        // Create updated user with validated values
        self.user = User(name: name, email: email, role: role)
        
        print("DEBUG: Updated user - Name: \(name), Email: \(email), Role: \(role)")
        
        // NOW trigger unwind - AFTER updating the user
            performSegue(withIdentifier: "unwindFromEditUser", sender: self)

    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    // Dismiss keyboard when tapping outside
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}


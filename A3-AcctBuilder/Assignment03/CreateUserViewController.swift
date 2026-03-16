
//  ViewController.swift
//  Assignment03
//  Assignent3
//  Created by Ted Salmon on 1/28/26.
//


import UIKit
// User Information
class User {
    let name: String
    let email: String
    let role: String
// initalize new user
    init(name: String, email: String, role: String) {
        self.name = name
        self.email = email
        self.role = role
    }
}
// View controller responsible for creating a new user
class CreateUserViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up segmented control
        roleSegment.removeAllSegments()
        roleSegment.insertSegment(withTitle: "Student", at: 0, animated: false)
        roleSegment.insertSegment(withTitle: "Employee", at: 1, animated: false)
        roleSegment.insertSegment(withTitle: "Other", at: 2, animated: false)
        roleSegment.selectedSegmentIndex = 0

        // Set text field delegates
        nameField.delegate = self
        emailField.delegate = self
    
    }
    // outlets for input fields
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var roleSegment: UISegmentedControl!
    
    // handler for 'next' button
    // validates user, creates objext, and navigatesto profile screen
    @IBAction func nextButtonTapped(_ sender: Any) {
        let name = nameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let email = emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let selectedIndex = roleSegment.selectedSegmentIndex
        let role = selectedIndex >= 0 ? (roleSegment.titleForSegment(at: selectedIndex) ?? "") : ""

        // Validate inputs and show alerts
        if name.isEmpty {
            showAlert(title: "Missing Name", message: "Please enter your name.")
            return
        }
        if email.isEmpty {
            showAlert(title: "Missing Email", message: "Please enter your email.")
            return
        }
        if role.isEmpty {
            showAlert(title: "Missing Role", message: "Please select your role.")
            return
        }
        // creates user
        let user = User(name: name, email: email, role: role)
        // navigate to profile screen, passing user input
        performSegue(withIdentifier: "showProfile", sender: user)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

//    // Dismiss keyboard when tapping outside
//    @objc private func dismissKeyboard() {
//        view.endEditing(true)
   // }
    
    // handling the return key
    // dismisses keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameField {
            emailField.becomeFirstResponder()
        } else if textField == emailField {
            textField.resignFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }

    // MARK: - Navigation
    // preparing for another view controller
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showProfile", let user = sender as? User else { return }
        // Handle either a direct ProfileViewController destination or one wrapped in a UINavigationController
        if let profileVC = segue.destination as? ProfileViewController {
            profileVC.user = user
        } else if let nav = segue.destination as? UINavigationController,
                  let profileVC = nav.topViewController as? ProfileViewController {
            profileVC.user = user
        }
    }

}

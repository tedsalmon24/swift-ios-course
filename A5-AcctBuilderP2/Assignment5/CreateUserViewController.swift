// -- [Segue example] CreateUser > Profile --
// -- [Unwind example] SelectRole > CreateUser --
// step 1: create unwind method in destination
// step 2:  In source VC, store the data
// step 3: Connect in storyboard: Drag from button to Exit icon, select unwind method
// -- [Delegate example] SelectLiving > CreateUser --
// Step 1 - Define the protocol:
// Step 2 - Add delegate property and call it:
// Step 3 - Conform to protocol and set self as delegate:
// -- [Notification example] SelectIncome > CreateUser
// Step 1 - POST
// Step 2 - OBSERVE
// STEP 3 - HANDLE

//  CreateUserViewController.swift
//  Assignment5
//
//  Created by Ted Salmon on 2/4/26.
//

import UIKit

class CreateUserViewController: UIViewController {
    var user: User? { didSet { if isViewLoaded { configureView() } } }
    

    var isEditingMode = false
    
    class User {
        var name: String?
        var email: String?
        var role: String?
        var income: String?
        var status: String?
        // initalizer
        // create student with required fields
        init(name: String, email: String, role: String, income: String, status: String) {
            self.name = name
            self.email = email
            self.role = role
            self.income = income
            self.status = status
        }
    }
    
    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var incomeLabel: UILabel! // observe IncomeChanged
    @IBOutlet weak var statusLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //configure UI with updated data
        configureView()
        
        
        //Notification observer // Register as observer STEP 2
        NotificationCenter.default.addObserver(self, selector: #selector(onReceieveNotify(_:)), name: Notification.Name("IncomeChanged"), object: nil)
    }
    private func configureView() {
        //guard let = safely unwrap optional
        // If student is nil, exit early (return)
        guard let user = user else { return }
        // Set navigation bar title to student name
        // Populate all labels with student properties
        nameField.text = user.name
        emailField.text = user.email
        roleLabel.text = user.role
        incomeLabel.text = user.income
        statusLabel.text = user.status
    }
    
    //Notification Center // Method that handles the notification STEP 3
    @objc func onReceieveNotify(_ notification: Notification) {
        incomeLabel.text = notification.object as? String // Extract data
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        //        guard let user = user else { return }
        let name = nameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let email = emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let role = roleLabel.text ?? ""
        let incomeLabelText = incomeLabel.text ?? ""
        let statusLabelText = statusLabel.text ?? ""
        
        // validate inputs
        if name.isEmpty {
            showAlert(title: "Missing Name", message: "Please enter your name.")
            return
        }
        if email.isEmpty {
            showAlert(title: "Missing Email", message: "Please enter your email.")
            return
        }
        if role.isEmpty || role == "N/A" {
            showAlert(title: "Missing Role", message: "Please select your role.")
            return
        }
        if incomeLabelText.isEmpty || incomeLabelText == "N/A" {
            showAlert(title: "Missing Id", message: "Please enter your income.")
            return
        }
        if statusLabelText.isEmpty || statusLabelText == "N/A" {
            showAlert(title: "Missing Id", message: "Please enter your status.")
            return
        }
        // create user from
        let newUser = User(name: name, email: email, role: role, income: incomeLabelText, status: statusLabelText)
        
        // Trigger the segue with data [SEGUE EXAMPLE 1]
        performSegue(withIdentifier: "showProfile", sender: newUser)
        
    }
    //show alert
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    // [UNWIND EXAMPLE] collect data from role picker : [STEP 1]
    @IBAction func unwindFromRolePicker(_ segue: UIStoryboardSegue) {
        if let sourceVC = segue.source as? SelectRoleViewController,
           let role = sourceVC.selectedRole {
            roleLabel.text = role
        }
    }
    // dismiss keyboard on touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Prepare called, segue: \(segue.identifier ?? "nil")")
        if segue.identifier == "goToStatus" {
            let vc = segue.destination as! SelectLivingStatusViewController
            vc.delegate = self // CRITICAL: Set self as delegate PROTOCOL EXAMPLE
        }
        // Passing the user data to profile screen via segue [SEGUE EXAMPLE 1]
        if segue.identifier == "showProfile" {
            let vc = segue.destination as! ProfileViewController
            vc.user = sender as? User // Pass the user object
        }
    }
}
// Add the protocol conformance [PROTOCOL EXAMPLE] [STEP 1]
extension CreateUserViewController: StatusDelegate {
    func didSelectStatus(_ status: String) {
        statusLabel.text = status // Receive the data!
        print("Selected status: \(status)")
    }
}

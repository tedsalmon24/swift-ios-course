//  Assignment04
//  ViewController.swift
//  Created by Ted Salmon on 2/3/26.

import UIKit
// MARK: - Main View Controller (Create User Screen)
class ViewController: UIViewController {
    //store avatar from selectAvatarVC
    //starts as nil
    var selectedAvatar: UIImage?
    // student data
    // referenced ViewController.Student everywhere else
    class Student {
        var name: String?
        var email: String?
        var studentId: String?
        var department: String?
        var avatar: UIImage?
        // initalizer
        // create student with required fields
        init(name: String, email: String, studentId: String, department: String, avatar: UIImage? = nil) {
            self.name = name
            self.email = email
            self.studentId = studentId
            self.department = department
            self.avatar = avatar
        }
    }
    
    // holds current student - not used in this VC but available elsewhere
    var student: ViewController.Student?
    
    // outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var StudentIDTextField: UITextField!
    @IBOutlet weak var departmentControl: UISegmentedControl!
    //  button showing avatar
    @IBOutlet weak var avatarSelector: UIButton!
    // could store default image for comparison - not used
    var initialAvatarImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view

    }
    // STEP 1: Extract and clean text field values
    @IBAction func saveClicked(_ sender: Any) {
        let name = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let studentId = StudentIDTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        // STEP 2: Get selected segment from UISegmentedControl
        let department = departmentControl.selectedSegmentIndex
        // Get title text of selected segment
        let role = department >= 0 ? (departmentControl.titleForSegment(at: department) ?? "") : ""
        
        
        
        // Validate inputs and show alerts
        if selectedAvatar == nil {
            showAlert(title: "Missing Avatar", message: "Please select an avatar.")
            return
        }
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
        if studentId.isEmpty {
            showAlert(title: "Missing Id", message: "Please enter your ID.")
            return
        }
        // creates user with validated information
        let user = Student(name: name, email: email, studentId: studentId, department: role, avatar: selectedAvatar)
        // STEP 5: Trigger segue to ProfileViewController
        // navigate to profile screen, passing user input
        performSegue(withIdentifier: "showProfile", sender: user)
    }
    //show alert
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    // MARK: Navigation / Segue Methods
    // pass data to destinations VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProfile" {
            let profileVC = segue.destination as! ProfileViewController
            let user = sender as! Student
            profileVC.student = user
        }
    }
    // dismiss keyboard on touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: Unwind Segues
    // Unwind segues return from a presented VC back to this one
    @IBAction func unwindFromAvatarPicker(_ segue: UIStoryboardSegue) {
        
        // Get the VC we are unwinding FROM
        let sourceVC = segue.source as! SelectAvatarViewController
        
        // Get the selected image
        if let avatar = sourceVC.selectedAvatar {
            avatarSelector.setImage(avatar, for: .normal)
            selectedAvatar = avatar
        }
    }
    
}


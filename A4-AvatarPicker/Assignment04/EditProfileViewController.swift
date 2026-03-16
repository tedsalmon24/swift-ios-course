//  Assignment04
//  EditProfileViewController.swift
//  Created by Ted Salmon on 2/3/26.

import UIKit

class EditProfileViewController: UIViewController {
    // Student data passed from ProfileViewController
    // Pre-populates form fields in viewDidLoad
    var student: ViewController.Student?
    // Delegate reference to send data back to ProfileViewController
    // Set in ProfileViewController's prepare(for:sender:)
    //var dataBackDelegate: DataBackDelegate?
    // outlets
    @IBOutlet weak var editName: UITextField!
    @IBOutlet weak var editEmail: UITextField!
    @IBOutlet weak var editID: UITextField!
    @IBOutlet weak var editDept: UISegmentedControl!
    @IBOutlet weak var editAvatar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: Set Segment Control to Match Current Department
        if let dept = student?.department {
            switch dept {
            case "CS":
                editDept?.selectedSegmentIndex = 0
            case "SIS":
                editDept?.selectedSegmentIndex = 1
            case "BIO":
                editDept?.selectedSegmentIndex = 2
            default:
                editDept?.selectedSegmentIndex = 3
            }
        }
        // populate fields with existing values from the user object
        editName?.text = student?.name
        editEmail?.text = student?.email
        editID?.text = student?.studentId
        // Set button image to current avatar
        editAvatar?.setImage(student?.avatar, for: .normal)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        // MARK: Step 1 - Validate Required Fields
        // Validate inputs before updating the student object
        // (the student object is updated in prepare(for:sender:) right before the unwind)
        if editName.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true {
            showAlert(title: "Missing Name", message: "Please enter your name.")
            return
        }
        if editEmail.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true {
            showAlert(title: "Missing Email", message: "Please enter your email.")
            return
        }
        if editID.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true {
            showAlert(title: "Missing Id", message: "Please enter your ID.")
            return
        }
        
        // MARK: Step 3 - Trigger Unwind Segue to Send Data Back
        // The unwind segue calls prepare(for:sender:) before unwinding,
        // which keeps the student object up to date for the destination VC.
        // The unwind segue also handles dismissal automatically.
        performSegue(withIdentifier: "unwindToProfile", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "unwindToProfile" {
            // Update the student object with current form values
            // so the destination VC receives the latest data
            student?.name = editName.text ?? ""
            student?.email = editEmail.text ?? ""
            student?.studentId = editID.text ?? ""
            student?.department = editDept.titleForSegment(at: editDept.selectedSegmentIndex) ?? ""
            student?.avatar = editAvatar.image(for: .normal)
        }
    }
    // MARK: Helper Methods
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    
    // dismiss keyboard on touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Called when returning from SelectAvatarViewController
    // Updates avatar button with newly selected image
    @IBAction func unwindFromAvatarPicker(_ segue: UIStoryboardSegue) {
        // Get the VC we are unwinding FROM
        let sourceVC = segue.source as! SelectAvatarViewController
        // If an avatar was selected, update the button image
        if let avatar = sourceVC.selectedAvatar {
            editAvatar.setImage(avatar, for: .normal)
        }
    }
}

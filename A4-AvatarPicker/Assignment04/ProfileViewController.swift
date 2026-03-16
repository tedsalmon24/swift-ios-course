//  Assignment04
//  ProfileViewController.swift
//  Created by Ted Salmon on 2/3/26.

import UIKit


// MARK: Delegate Protocol Definition
// Any class that conforms must implement sendBack(student:) = CONTRACT
// Used to pass data BACK from EditProfileViewController to here
//protocol DataBackDelegate {
//    func sendBack(student: ViewController.Student)
//}



class ProfileViewController: UIViewController {
    var student: ViewController.Student? { didSet { if isViewLoaded { configureView() } } }
    //outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var studentIdLabel: UILabel!
    @IBOutlet weak var deptLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Configure UI with student data on first load
        configureView()
    }
    
    // Update all labels and the title from the current student
    // Called from: viewDidLoad() and didSet when student changes
    private func configureView() {
        // guard let = safely unwrap optional
        // If student is nil, exit early (return)
        guard let student = student else { return }
        // Set navigation bar title to student name
        self.title = student.name
        // Populate all labels with student properties
        nameLabel.text = student.name
        emailLabel.text = student.email
        studentIdLabel.text = student.studentId
        deptLabel.text = student.department
        imageLabel.image = student.avatar
    }
    
    // MARK: Navigation
    // Called automatically BEFORE segue to EditProfileViewController
    // Pass current student data and set up delegate for return data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Check segue identifier matches
        if segue.identifier == "goToSecondVCSegue" {
            // Get reference to destination
            let vc = segue.destination as! EditProfileViewController
            // Pass current student data TO edit screen
            vc.student = self.student
            // Set THIS VC as the delegate
            // EditProfileViewController will call self.sendBack() when done
            //vc.dataBackDelegate = self
        }
    }
    
    // dismiss keyboard on touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    // MARK: - Unwind Segue
    // This method is called when unwinding FROM EditProfileViewController
    @IBAction func unwindFromEditProfile(_ segue: UIStoryboardSegue) {
        // Get the source VC (EditProfileViewController)
        if let sourceVC = segue.source as? EditProfileViewController,
           let updatedStudent = sourceVC.student {
            // Update our student with the edited data
            self.student = updatedStudent
        }
    }
}

//extension ProfileViewController: DataBackDelegate {
//    func sendBack(student: ViewController.Student) {
//        // Update the student property
//        // This triggers didSet, which calls configureView() automatically!
//        self.student = student
//    }
//}


//  ViewController.swift
//  Assignment03
//  Assignent3
//  Created by Ted Salmon on 1/28/26.
//

import UIKit

// MARK: proview view controller
// display user information and allow edit
class ProfileViewController: UIViewController {
    var user: User? { didSet { if isViewLoaded { configureView() } } }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = user { self.title = user.name }
        configureView()
    }
    
    // MARK: outlets
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileEmail: UILabel!
    @IBOutlet weak var roleSegment: UILabel!


    private func configureView() {
        guard let user = user else { 
            print("DEBUG configureView: user is nil")
            return 
        }
        // Ensure outlets are loaded before trying to set them
        guard isViewLoaded else { 
            print("DEBUG configureView: view not loaded yet")
            return 
        }
        
        print("DEBUG configureView: About to update UI with - Name: '\(user.name)', Email: '\(user.email)', Role: '\(user.role)'")
        // update the labels
        profileName?.text = user.name
        profileEmail?.text = user.email
        roleSegment?.text = user.role
        // debug to see whats stored
        print("DEBUG configureView: UI updated. Label texts are now:")
        print("  - profileName.text: '\(profileName?.text ?? "nil")'")
        print("  - profileEmail.text: '\(profileEmail?.text ?? "nil")'")
        print("  - roleSegment.text: '\(roleSegment?.text ?? "nil")'")
        
    }
    // MARK: - Actions
    /// handle update button
    @IBAction func updateButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "editUser", sender: self)
    }

    // MARK: - Navigation
    // preps the navigation to edit user controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editUser",
           let editVC = segue.destination as? EditUserViewController {
            editVC.user = user
        }
    }

    // Unwind segue action to receive updated user
    // How we go back to previous screen!
    @IBAction func unwindFromEditUser(_ segue: UIStoryboardSegue) {
        print("DEBUG: Unwind segue called")
        if let source = segue.source as? EditUserViewController {
            print("DEBUG: Source is EditUserViewController")
            if let sourceUser = source.user {
                print("DEBUG: Source user - Name: '\(sourceUser.name)', Email: '\(sourceUser.email)', Role: '\(sourceUser.role)'")
            } else {
                print("DEBUG: Source user is nil")
            }
            // Update this view controller's user with the edited information
            self.user = source.user
            
            if let currentUser = self.user {
                print("DEBUG: ProfileViewController user NOW - Name: '\(currentUser.name)', Email: '\(currentUser.email)', Role: '\(currentUser.role)'")
            } else {
                print("DEBUG: ProfileViewController user is nil")
            }
            // Refresh the UI to show the updated information
            configureView()
            print("DEBUG: configureView() called")
        } else {
            print("DEBUG: Source is NOT EditUserViewController")
        }
    }
}


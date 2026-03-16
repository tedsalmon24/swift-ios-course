//  Assignment5
//  ProfileViewController.swift
//  Created by Ted Salmon on 2/6/26.
//

import UIKit

class ProfileViewController: UIViewController {

    
    // Receive the user from CreateUserViewController [SEGUE EXAMPLE 1]
    var user: CreateUserViewController.User?
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Use the Segued information [SEGUE EXAMPLE 1]
        configureView()
        //unwrap information
    }
    // Use the Segued information [SEGUE EXAMPLE 1]
    private func configureView() {
        guard let user = user else { return }
        //set
        nameLabel.text = user.name
        emailLabel.text = user.email
        roleLabel.text = user.role
        incomeLabel.text = user.income
        statusLabel.text = user.status

    }
    
    // prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToEdit" {
            let vc = segue.destination as! CreateUserViewController
            vc.user = self.user
            vc.isEditingMode = true
        }
    }
    
    
    @IBAction func updateClicked(_ sender: Any) {
        performSegue(withIdentifier: "goToEdit", sender: nil)
    }
    
    // Receive updated user back
    @IBAction func unwindFromEdit(_ segue: UIStoryboardSegue) {
        if let sourceVC = segue.source as? CreateUserViewController,
           let updatedUser = sourceVC.user {
            self.user = updatedUser
            configureView()
        }
    }

}

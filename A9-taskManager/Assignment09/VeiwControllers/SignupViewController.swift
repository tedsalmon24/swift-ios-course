// ted salmon
//  SignupViewController.swift
//  Assignment09
//
//  Created by Mohamed Shehab on 3/18/26.
//

import UIKit
import FirebaseAuth

class SignupViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        
        //intialize
        let name = nameTextField.text ?? ""
        let email = self.emailTextField.text ?? ""
        let password = self.passwordTextField.text ?? ""
        
        if name.isEmpty || email.isEmpty || password.isEmpty {
            self.showAlert(title: "Registration Error", message: "Please fill in all fields.")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.showAlert(title: "Registration Error", message: error.localizedDescription)
                return
            }
            
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = name
            changeRequest?.commitChanges { error in
                if let error = error {
                    self.showAlert(title: "Registration Error", message: error.localizedDescription)
                    return
                }
                SceneDelegate.showTasks()
            }
        }
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        SceneDelegate.showLogin()
    }

}

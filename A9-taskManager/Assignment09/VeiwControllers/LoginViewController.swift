//ted salmon
//  LoginViewController.swift
//  Assignment09
//
//  Created by Mohamed Shehab on 3/18/26.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        //need to call SceneDelegate.showTasks()
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        if email.isEmpty || password.isEmpty {
            print("enter email/password")
            self.showAlert(title: "Login Error", message: "Please enter both email and password")
        }else{
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if error == nil {
                    print("success")
                    SceneDelegate.showTasks()
                } else {
                    self.showAlert(title: "Login Error", message: error?.localizedDescription ?? "An error occurred")
                }
            }
        }
    }
    
    @IBAction func createAccountClicked(_ sender: Any) {
        SceneDelegate.showSignUp()
    }
    
}

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

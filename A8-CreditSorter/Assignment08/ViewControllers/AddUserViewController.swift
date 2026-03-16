// Ted Salmon
//  AddUserViewController.swift
//  Assessment03
//
//  Created by Mohamed Shehab on 3/18/25.
//

import UIKit

// create protocol to send data back
protocol AddUserViewControllerDelegate: AnyObject {
    func didAddUser(_ user: User)
}

// delegate was added here,
class AddUserViewController: UIViewController, SelectStateViewControllerDelegate {
    var selectedState: State?
    
    // this is the delegate property
    weak var delegate: AddUserViewControllerDelegate?
    
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var creditScoreTextField: UITextField!
    @IBOutlet weak var stateLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectStateSegue" {
            let nav = segue.destination as! UINavigationController
            let vc = nav.viewControllers.first as! SelectStateViewController
            vc.delegate = self
            
        }
    }
    @IBAction func cancelClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        let name = self.nameTextField.text!
        if name.isEmpty {
            self.alertPrompt(title: "Error", message: "Enter name!")
        } else {
            if let age = Int(self.ageTextField.text!) {
                if age < 0 || age > 120 {
                    self.alertPrompt(title: "Error", message: "Enter valid age!")
                } else {
                    if let creditScore = Int(self.creditScoreTextField.text!) {
                        if creditScore < 300 || creditScore > 850 {
                            self.alertPrompt(title: "Error", message: "Enter valid credit score! Between 300 and 850")
                        } else {
                            if selectedState != nil {
                                let user = User(name: name, age: age, creditScore: creditScore, state: selectedState!.getNameAbvComma())
                                // this is the call back
                                delegate?.didAddUser(user)
                                dismiss(animated: true)
                            } else {
                                self.alertPrompt(title: "Error", message: "Select state!")
                            }
                            
                        }
                    } else {
                        self.alertPrompt(title: "Error", message: "Enter credit score!")
                    }
                }
            } else {
                self.alertPrompt(title: "Error", message: "Enter age!")
            }
        }
    }
}

// MARK: - SelectStateViewControllerDelegate
extension AddUserViewController {
    func didSelectState(_ state: State) {
        self.selectedState = state
        self.stateLabel.text = state.getNameAbvComma()
    }
}



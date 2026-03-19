//ted salmon
//  AddNewTaskViewController.swift
//  Assignment09
//
//  Created by Mohamed Shehab on 3/18/26.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class AddNewTaskViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    var selectedPriority: String?
    var selectedCategory: String?
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBAction func submitClicked(_ sender: Any) {
        
        
        let name = nameTextField.text ?? ""
        if name.isEmpty {
            showAlert(title: "Error", message: "Name cannot be empty")
        } else if selectedPriority == nil {
            showAlert(title: "Error", message: "Please select a priority")
        } else if selectedCategory == nil {
            showAlert(title: "Error", message: "Please select a category")
        } else {
            // store in db
            let db = Firestore.firestore()
            let docRef = db.collection("note").document()
            
            // Build the data dictionary to store in the document.
            let data : [String:Any] = [
                "docID" : docRef.documentID,
                "title" : name,
                "priority" : selectedPriority!,
                "category" : selectedCategory!,
                "createdAt" : FieldValue.serverTimestamp(),
                "createdByUID" : Auth.auth().currentUser!.uid
            ]
            docRef.setData(data) { (error) in
                if let error = error {
                    print(error)
                } else {
                    print("success")
                    SceneDelegate.showTasks()
                }
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectPrioritySegue" {
            let vc = segue.destination as! SelectPriorityViewController
            vc.delegate = self
        } else if segue.identifier == "SelectCategorySegue" {
            let vc = segue.destination as! SelectCategoryViewController
            vc.delegate = self
        }
    }
    
    
    @IBAction func cancelClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
}


extension AddNewTaskViewController: SelectPriorityDelegate {
    func didSelectPriority(_ priority: String) {
        self.selectedPriority = priority
        self.priorityLabel.text = priority
    }
}

extension AddNewTaskViewController: SelectCategoryDelegate {
    func didSelectCategory(_ category: String) {
        self.selectedCategory = category
        self.categoryLabel.text = category
    }
}

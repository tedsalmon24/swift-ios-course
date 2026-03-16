//  Assignment5
//  SelectRoleViewController.swift
//  Created by Ted Salmon on 2/4/26.

import UIKit

class SelectRoleViewController: UIViewController {

    @IBOutlet weak var roleControl: UISegmentedControl!
    
    // store selection here [UNWIND EXAMPLE]
    var selectedRole: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }
    
    
    
    
    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    // pass data to VC 1 [UNWIND EXAMPLE] [STEP 2]
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToFirstVC" {
            // fetch the selected segment's title
            let selectedIndex = roleControl.selectedSegmentIndex
            selectedRole = roleControl.titleForSegment(at: selectedIndex)
            
        }
    }


}

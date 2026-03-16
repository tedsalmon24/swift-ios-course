//  Assignment5
//  SelectLivingStatusViewController.swift
//  Created by Ted Salmon on 2/4/26.

import UIKit

// MARK: - Protocol
// define protocol [STEP 1]
protocol StatusDelegate {
    func didSelectStatus(_ status: String)
}

// Step 2 - Add delegate property and call it:
class SelectLivingStatusViewController: UIViewController {
    
    var delegate: StatusDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    // connection to all buttons
    @IBAction func statusButtonTapped(_ sender: UIButton) {
        // set status to title
        let status = sender.currentTitle ?? sender.configuration?.title
        
        // if not cancel, then delegate status
        if let status = status, status != "Cancel" {
            delegate?.didSelectStatus(status)
        }
        //dismiss view if selected
        dismiss(animated: true)
    }
}

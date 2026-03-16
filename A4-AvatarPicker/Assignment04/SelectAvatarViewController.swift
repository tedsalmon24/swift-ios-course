//  Assignment04
//  SelectAvatarViewController.swift
//  Created by Ted Salmon on 2/3/26.

import UIKit

class SelectAvatarViewController: UIViewController {

    var selectedAvatar: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func avatarButtonTapped(_ sender: UIButton) {
        selectedAvatar = sender.imageView?.image
        
        print("Selected avatar: \(String(describing: selectedAvatar))")
        
        performSegue(withIdentifier: "unwindToProfile", sender: self)
    }

}

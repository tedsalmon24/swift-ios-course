//  Assignment5
//  SelectIncomeViewController.swift
//  Created by Ted Salmon on 2/4/26.
import UIKit

class SelectIncomeViewController: UIViewController {
    
    // Store the selected income level (0-4)
    var selectedLevel: Int = 0
    
    //outlets
    @IBOutlet weak var incomeSlider: UISlider!
    @IBOutlet weak var incomeLabel: UILabel!  // Add this outlet
    
    let incomeLevels = ["<$25K", "$25K to <$50K", "$50K to <$100K", "$100K to <$200K", ">$200K"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set initial label
        incomeLabel.text = incomeLevels[0]
        // Do any additional setup after loading the view.
    }
    


    @IBAction func sliderValue(_ sender: UISlider) {
        print("Slider raw value: \(sender.value)")
        // Round to nearest whole number (0, 1, 2, 3, or 4)
        selectedLevel = Int(round(sender.value))
        
        // Snap slider to the rounded value
        sender.value = Float(selectedLevel)
        
        // Update the label
        incomeLabel.text = incomeLevels[selectedLevel]
    }
    
    
    @IBAction func submitClicked(_ sender: Any) {
        let incomeString = incomeLevels[selectedLevel]
        // Post notification with name and data STEP 1
        NotificationCenter.default.post(name: Notification.Name("IncomeChanged"), object: incomeString)
        dismiss(animated: true)
    }
    
    
    @IBAction func closeClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
}

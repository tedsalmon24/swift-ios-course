//  Assignment 01
//  ViewController.swift
//  TemperatureConverter
//  Created by Ted Salmon on 1/21/26.


import UIKit

class ViewController: UIViewController {
    
    
    // Temperature Text Field
    @IBOutlet weak var tempTextField: UITextField!
    // conversion label
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var conversionSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // C to F button
    @IBAction func celToF(_ sender: UIButton) {
        
        guard let text = tempTextField.text,
              let temp = Double(text) else {
            resultLabel.text = "Invalid input"
            return
        }
        let result = (temp * 9 / 5) + 32
        resultLabel.text = String(format: "%.2f °F", result)
    }
    func convertCtoF(_ temp: Double) -> Double {
        return (temp * 9 / 5) + 32
    }
    
    func convertFtoC(_ temp: Double) -> Double {
        return (temp - 32) * 5 / 9
    }
    
    // F to C button
    @IBAction func fahToCel(_ sender: UIButton) {
        guard let text = tempTextField.text,
              let temp = Double(text) else {
            resultLabel.text = "Invalid input"
            return
        }
        
        let result = (temp - 32) * 5 / 9
        resultLabel.text = String(format: "%.2f °C", result)
    }
    
    // Reset button
    @IBAction func reset(_ sender: UIButton) {
        //reset textbox, label and history
        tempTextField.text = ""
        resultLabel.text = ""
    }
    
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        guard let text = tempTextField.text, let temp = Double(text) else {
            resultLabel.text = "Invalid input"
            return
        }
        if conversionSegment.selectedSegmentIndex == 0 {
            // C to F
            let result = (temp * 9 / 5) + 32
            resultLabel.text = String(format: "%.2f °F", result)
        } else {
            // F to C
            let result = (temp - 32) * 5 / 9
            resultLabel.text = String(format: "%.2f °C", result)
        }
    }
}


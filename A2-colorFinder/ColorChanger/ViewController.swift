//  Assignment 02
//  ViewController.swift
//  ColorChanger
//  Created by Ted Salmon on 1/22/26.

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Slider ranges
            redSlider.minimumValue = 0
            redSlider.maximumValue = 255

            greenSlider.minimumValue = 0
            greenSlider.maximumValue = 255

            blueSlider.minimumValue = 0
            blueSlider.maximumValue = 255

            // Initial values (Fig 1a)
            redSlider.value = 64
            greenSlider.value = 128
            blueSlider.value = 0

            updateColor()
    }
    // color picture
    @IBOutlet weak var colorView: UIView!
    //red slider
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var redValueLabel: UILabel!
    //green slider
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var greenValueLabel: UILabel!
    // blue slider
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var blueValueLabel: UILabel!
    //hex label that changes
    @IBOutlet weak var hexLabel: UILabel!
    // RGB label that changes
    @IBOutlet weak var rgbLabel: UILabel!
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        sender.value = round(sender.value)
        updateColor()
    }
    
    func updateColor() {
        let r = Int(redSlider.value)
        let g = Int(greenSlider.value)
        let b = Int(blueSlider.value)

        let color = UIColor(
            red: CGFloat(r) / 255.0,
            green: CGFloat(g) / 255.0,
            blue: CGFloat(b) / 255.0,
            alpha: 1.0
        )
        
        colorView.backgroundColor = color

        // RGB label
        redValueLabel.text = "\(r)"
        greenValueLabel.text = "\(g)"
        blueValueLabel.text = "\(b)"

        rgbLabel.text = "Color RGB: (\(r), \(g), \(b))"
        hexLabel.text = String(format: "Color HEX: #%02X%02X%02X", r, g, b)
    }
    
    //Preset buttons below
    @IBAction func resetPressed(_ sender: UIButton) {
        redSlider.value = 64
        greenSlider.value = 128
        blueSlider.value = 0
        updateColor() // Refresh the UI
    }

    @IBAction func whitePressed(_ sender: UIButton) {
        redSlider.value = 255; greenSlider.value = 255; blueSlider.value = 255
        updateColor()
    }

    @IBAction func blackPressed(_ sender: UIButton) {
        redSlider.value = 0; greenSlider.value = 0; blueSlider.value = 0
        updateColor()
    }

    @IBAction func bluePressed(_ sender: UIButton) {
        redSlider.value = 0; greenSlider.value = 0; blueSlider.value = 255
        updateColor()
    }
    
}


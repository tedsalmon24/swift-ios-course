// Ted Salmon
//  User.swift
//  Assessment03
//
//  Created by Mohamed Shehab on 3/18/25.
//

import UIKit

class User {
    var name: String
    var age: Int
    var creditScore: Int
    var state: String
    
    init(name: String, age: Int, creditScore: Int, state: String) {
        self.name = name
        self.age = age
        self.creditScore = creditScore
        self.state = state
    }
}

class State {
    var name: String
    var abbreviation: String
    init(name: String, abbreviation: String) {
        self.name = name
        self.abbreviation = abbreviation
    }
    
    func getNameAbvSpace() -> String {
        return "\(name) (\(abbreviation))"
    }
    
    func getNameAbvComma() -> String {
        return "\(name), \(abbreviation)"
    }
}


class CreditCategory{
    var name: String
    var iconImageName: String
    init(name: String, iconImageName: String) {
        self.name = name
        self.iconImageName = iconImageName
    }
}

extension UIViewController {
    
    func alertPrompt (title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func alertPrompt(title: String, message: String, okHandler: @escaping ((UIAlertAction) -> Void)){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: okHandler))
        self.present(alert, animated: true, completion: nil)
    }
    
    func alertPrompt(title: String, message: String, okHandler: @escaping ((UIAlertAction) -> Void), cancelHandler:  @escaping ((UIAlertAction) -> Void)){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: okHandler))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: cancelHandler))
        self.present(alert, animated: true, completion: nil)
    }
    
    func alertPromptDestructive(title: String, message: String, okHandler: @escaping ((UIAlertAction) -> Void), cancelHandler:  @escaping ((UIAlertAction) -> Void)){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: okHandler))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: cancelHandler))
        self.present(alert, animated: true, completion: nil)
    }
}

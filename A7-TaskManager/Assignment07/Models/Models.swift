//
//  Models.swift
//  Assignment07
//
//  Created by Mohamed Shehab on 3/11/25.
//

import UIKit

class Task {
    var name: String
    var priority: Int
    var date: Date
    init(name: String, priority: Int, date: Date) {
        self.name = name
        self.priority = priority
        self.date = date
    }
}

class SortSelection{
    var sortAttribute: String
    var isAscending: Bool
    init(sortAttribute: String, isAscending: Bool) {
        self.sortAttribute = sortAttribute
        self.isAscending = isAscending
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

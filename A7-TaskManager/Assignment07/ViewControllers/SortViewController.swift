// Ted Salmon
//  SortViewController.swift
//  Assignment07
//
//  Created by Mohamed Shehab on 3/11/25.
//

import UIKit

protocol SortViewControllerDelegate {
    func didSelectSort(sortSelection: SortSelection)
}

class SortViewController: UIViewController {
    var delegate: SortViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nameAscClicked(_ sender: Any) {
        let sortSelection = SortSelection(sortAttribute: "name", isAscending: true)
        self.delegate!.didSelectSort(sortSelection: sortSelection)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nameDescClicked(_ sender: Any) {
        let sortSelection = SortSelection(sortAttribute: "name", isAscending: false)
        self.delegate!.didSelectSort(sortSelection: sortSelection)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dateAscClicked(_ sender: Any) {
        let sortSelection = SortSelection(sortAttribute: "date", isAscending: true)
        self.delegate!.didSelectSort(sortSelection: sortSelection)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dateDescClicked(_ sender: Any) {
        let sortSelection = SortSelection(sortAttribute: "date", isAscending: false)
        self.delegate!.didSelectSort(sortSelection: sortSelection)
        dismiss(animated: true, completion: nil)
    }
   
    @IBAction func priorityAscClicked(_ sender: Any) {
        let sortSelection = SortSelection(sortAttribute: "priority", isAscending: true)
        self.delegate!.didSelectSort(sortSelection: sortSelection)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func priorityDescClicked(_ sender: Any) {
        let sortSelection = SortSelection(sortAttribute: "priority", isAscending: false)
        self.delegate!.didSelectSort(sortSelection: sortSelection)
        dismiss(animated: true, completion: nil)
    }
}

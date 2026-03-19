//ted salmon
//  SelectPriorityViewController.swift
//  Assignment09
//
//  Created by Mohamed Shehab on 3/18/26.
//

import UIKit

protocol SelectPriorityDelegate {
    func didSelectPriority(_ priority: String)
}

class SelectPriorityViewController: UIViewController {
    var delegate: SelectPriorityDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "SingleItemTableViewCell", bundle: nil), forCellReuseIdentifier: "SingleItemTableViewCell")
    }
}

extension SelectPriorityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.priorities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SingleItemTableViewCell", for: indexPath) as! SingleItemTableViewCell
        let priority = Data.priorities[indexPath.row]
        cell.mainLabel.text = priority
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let priority = Data.priorities[indexPath.row]
        delegate?.didSelectPriority(priority)
        self.navigationController?.popViewController(animated: true)
    }
}

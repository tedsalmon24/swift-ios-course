//ted salmon
//  SelectCategoryViewController.swift
//  Assignment09
//
//  Created by Mohamed Shehab on 3/18/26.
//

import UIKit

protocol SelectCategoryDelegate {
    func didSelectCategory(_ category: String)
}

class SelectCategoryViewController: UIViewController {
    var delegate: SelectCategoryDelegate?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "SingleItemTableViewCell", bundle: nil), forCellReuseIdentifier: "SingleItemTableViewCell")
    }
}

extension SelectCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SingleItemTableViewCell", for: indexPath) as! SingleItemTableViewCell
        let category = Data.categories[indexPath.row]
        cell.mainLabel.text = category
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = Data.categories[indexPath.row]
        delegate?.didSelectCategory(category)
        self.navigationController?.popViewController(animated: true)
    }
}

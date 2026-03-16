// Ted Salmon
//  SelectStateViewController.swift
//  Assessment03
//
//  Created by Mohamed Shehab on 3/18/25.
//

import UIKit

// created delegate to send state back
protocol SelectStateViewControllerDelegate: AnyObject {
       func didSelectState(_ state: State)
   }

class SelectStateViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    weak var delegate: SelectStateViewControllerDelegate?

    let states: [State] = [
        State(name: "Alabama", abbreviation: "AL"),
        State(name: "Alaska", abbreviation: "AK"),
        State(name: "Arizona", abbreviation: "AZ"),
        State(name: "Arkansas", abbreviation: "AR"),
        State(name: "California", abbreviation: "CA"),
        State(name: "Colorado", abbreviation: "CO"),
        State(name: "Connecticut", abbreviation: "CT"),
        State(name: "Delaware", abbreviation: "DE"),
        State(name: "Florida", abbreviation: "FL"),
        State(name: "Georgia", abbreviation: "GA"),
        State(name: "Hawaii", abbreviation: "HI"),
        State(name: "Idaho", abbreviation: "ID"),
        State(name: "Illinois", abbreviation: "IL"),
        State(name: "Indiana", abbreviation: "IN"),
        State(name: "Iowa", abbreviation: "IA"),
        State(name: "Kansas", abbreviation: "KS"),
        State(name: "Kentucky", abbreviation: "KY"),
        State(name: "Louisiana", abbreviation: "LA"),
        State(name: "Maine", abbreviation: "ME"),
        State(name: "Maryland", abbreviation: "MD"),
        State(name: "Massachusetts", abbreviation: "MA"),
        State(name: "Michigan", abbreviation: "MI"),
        State(name: "Minnesota", abbreviation: "MN"),
        State(name: "Mississippi", abbreviation: "MS"),
        State(name: "Missouri", abbreviation: "MO"),
        State(name: "Montana", abbreviation: "MT"),
        State(name: "Nebraska", abbreviation: "NE"),
        State(name: "Nevada", abbreviation: "NV"),
        State(name: "New Hampshire", abbreviation: "NH"),
        State(name: "New Jersey", abbreviation: "NJ"),
        State(name: "New Mexico", abbreviation: "NM"),
        State(name: "New York", abbreviation: "NY"),
        State(name: "North Carolina", abbreviation: "NC"),
        State(name: "North Dakota", abbreviation: "ND"),
        State(name: "Ohio", abbreviation: "OH"),
        State(name: "Oklahoma", abbreviation: "OK"),
        State(name: "Oregon", abbreviation: "OR"),
        State(name: "Pennsylvania", abbreviation: "PA"),
        State(name: "Rhode Island", abbreviation: "RI"),
        State(name: "South Carolina", abbreviation: "SC"),
        State(name: "South Dakota", abbreviation: "SD"),
        State(name: "Tennessee", abbreviation: "TN"),
        State(name: "Texas", abbreviation: "TX"),
        State(name: "Utah", abbreviation: "UT"),
        State(name: "Vermont", abbreviation: "VT"),
        State(name: "Virginia", abbreviation: "VA"),
        State(name: "Washington", abbreviation: "WA"),
        State(name: "West Virginia", abbreviation: "WV"),
        State(name: "Wisconsin", abbreviation: "WI"),
        State(name: "Wyoming", abbreviation: "WY")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up table view
        tableView.delegate = self
        tableView.dataSource = self
    }
    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true)
    }
}

// MARK: - UITableViewDataSource
extension SelectStateViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return states.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StateCell", for: indexPath)
        let state = states[indexPath.row]
        cell.textLabel?.text = state.name
        cell.detailTextLabel?.text = state.abbreviation
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SelectStateViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedState = states[indexPath.row]
        
        delegate?.didSelectState(selectedState)
        dismiss(animated: true)
    }
}


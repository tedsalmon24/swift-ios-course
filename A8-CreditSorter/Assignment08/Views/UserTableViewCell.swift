//
//  UserTableViewCell.swift
//  Assignment09
//
//  Created by Mohamed Shehab on 3/25/25.
//

import UIKit

protocol UserTableViewCellDelegate: AnyObject {
    func didTapDelete(on cell: UserTableViewCell)
}

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var creditLabel: UILabel!
    @IBOutlet weak var creditImageView: UIImageView!
    
    weak var delegate: UserTableViewCellDelegate?
    var user: User?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //delete button that deletes user
    @IBAction func deleteButtonPressed(_ sender: Any) {
        delegate?.didTapDelete(on: self)
    }
}

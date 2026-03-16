//
//  CreditTableViewCell.swift
//  Assignment09
//
//  Created by Mohamed Shehab on 3/25/25.
//

import UIKit

class CreditTableViewCell: UITableViewCell {

    @IBOutlet weak var creditLabel: UILabel!
    @IBOutlet weak var creditImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

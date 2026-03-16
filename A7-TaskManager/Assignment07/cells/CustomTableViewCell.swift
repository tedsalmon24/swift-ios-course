//
//  CustomTableViewCell.swift
//  Assignment07
//
//  Created by Ted Salmon on 2/25/26.
//

import UIKit
protocol CustomTVCellDelegate {
    func deleteIsClicked(cell: CustomTableViewCell)
    
}

class CustomTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!
    var delegate: CustomTVCellDelegate?

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        dateLabel.text = nil
        priorityLabel.text = nil
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func deletePressed(_ sender: Any) {
        print("deletePressed")
        delegate?.deleteIsClicked(cell: self)
    }
}

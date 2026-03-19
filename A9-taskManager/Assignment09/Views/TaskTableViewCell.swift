//ted salmon
//  TaskTableViewCell.swift
//  Assignment09
//
//  Created by Mohamed Shehab on 3/18/26.
//

import UIKit

protocol TaskTableViewCellDelegate {
    func didClickDelete(_ task: Task)
}


class TaskTableViewCell: UITableViewCell {
    var task: Task?
    var delegate: TaskTableViewCellDelegate?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bind(task: Task, delegate: TaskTableViewCellDelegate){
        self.task = task
        self.delegate = delegate
        
        // Set the label text from the task properties
        nameLabel.text = task.title
        categoryLabel.text = task.category
        priorityLabel.text = task.priority
    }
    
    @IBAction func trashClicked(_ sender: Any) {
        if let task = task {
            if let delegate = delegate {
                delegate.didClickDelete(task)
            }
        }
    }
}

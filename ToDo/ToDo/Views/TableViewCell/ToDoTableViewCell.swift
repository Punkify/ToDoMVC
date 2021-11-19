//
//  ToDoTableViewCell.swift
//  ToDo
//
//  Created by Hrishav on 19/11/21.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {

    
    @IBOutlet weak var createdDateLabel: UILabel!
    
    @IBOutlet weak var checkButton: UIView!
    
    @IBOutlet weak var taskToDoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

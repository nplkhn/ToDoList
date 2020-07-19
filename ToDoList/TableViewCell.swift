//
//  TableViewCell.swift
//  ToDoList
//
//  Created by Никита Плахин on 7/18/20.
//  Copyright © 2020 Никита Плахин. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var taskStatus: UIButton!
    @IBOutlet weak var taskTitle: UILabel!
    
    var state: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        taskStatus.setImage(UIImage(systemName: "sun.max"), for: .normal)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

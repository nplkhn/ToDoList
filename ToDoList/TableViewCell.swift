//
//  TableViewCell.swift
//  ToDoList
//
//  Created by Никита Плахин on 7/18/20.
//  Copyright © 2020 Никита Плахин. All rights reserved.
//

import UIKit
import CoreData

protocol ChangeButton {
    func toggleStatus(status: Bool, index: Int?)
}

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var taskStatus: UIButton!
    @IBOutlet weak var taskTitle: UILabel!
    var todoItems: [NSManagedObject] = []
    var index: Int?
    var delegate: ChangeButton?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        taskStatus.addTarget(self, action: #selector(self.toggleStatus), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func toggleStatus() {
        if let status = todoItems[index!].value(forKey: "status") as? Int {
            if status != 0 {
                delegate?.toggleStatus(status: false, index: index)
            } else {
                delegate?.toggleStatus(status: true, index: index)
            }
        }

    }
    
}

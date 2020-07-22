//
//  DescriptionViewController.swift
//  ToDoList
//
//  Created by Никита Плахин on 7/21/20.
//  Copyright © 2020 Никита Плахин. All rights reserved.
//

import UIKit
import CoreData

class DescriptionViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    var managedObject: NSManagedObject? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let managedObject = managedObject {
            titleLabel.text = managedObject.value(forKey: "title") as? String
            let timeInterval = (managedObject.value(forKey: "deadline") as? Date)?.timeIntervalSinceNow
            if let timeInterval = timeInterval {
                if timeInterval.isLessThanOrEqualTo(0.0){
                    deadlineLabel.text = "Expired"
                } else if timeInterval.isLess(than: 3600.0) {
                    deadlineLabel.text = "You have \(NSNumber(value: timeInterval).intValue / 60) minutes to do this task"
                } else if timeInterval.isLess(than: 86400.0) {
                    deadlineLabel.text = "You have \(NSNumber(value: timeInterval).intValue / 3600) hours to do this task"
                } else  {
                    deadlineLabel.text = "You have \(NSNumber(value: timeInterval).intValue / 84600) days to do this task"
                }
            }
            
        }
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

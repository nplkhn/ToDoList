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
    @IBOutlet weak var remainingTimeLabel: UILabel!
    var managedObject: NSManagedObject? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.accessibilityIdentifier = "descriptionView"
        self.titleLabel.accessibilityIdentifier = "descriptionTitleLabel"
        self.deadlineLabel.accessibilityIdentifier = "descriptionDeadlineLabel"
        self.remainingTimeLabel.accessibilityIdentifier = "descriptionRemainingTimeLabel"
        
        setupViews()
        // Do any additional setup after loading the view.
    }

    func setupViews() {
        if let managedObject = managedObject {
            titleLabel.text = managedObject.value(forKey: "title") as? String
            //            print(
            let deadlineDate = managedObject.value(forKey: "deadline") as? Date
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .short
            
            deadlineLabel.text = "Deadline: \(dateFormatter.string(from: deadlineDate!))"
            let timeInterval = (managedObject.value(forKey: "deadline") as? Date)?.timeIntervalSinceNow
            if (managedObject.value(forKey: "status") as? Int) == 1  {
                remainingTimeLabel.text = "Done"
                remainingTimeLabel.textColor = UIColor(red: 27.0/255.0, green: 135.0/255.0, blue: 72.0/255.0, alpha: 1)
            } else {
                if let timeInterval = timeInterval {
                    if timeInterval.isLessThanOrEqualTo(0.0){
                        remainingTimeLabel.text = "Already Expired"
                        remainingTimeLabel.textColor = UIColor(red: 225.0/255.0, green: 64.0/255.0, blue: 64.0/255.0, alpha: 1.0)
                    } else if timeInterval.isLess(than: 3600.0) {
                        remainingTimeLabel.text = "Expires in \(NSNumber(value: timeInterval).intValue / 60) minutes"
                    } else if timeInterval.isLess(than: 86400.0) {
                        remainingTimeLabel.text = "Expires in \(NSNumber(value: timeInterval).intValue / 3600) hours"
                    } else  {
                        remainingTimeLabel.text = "Expires in \(NSNumber(value: timeInterval).intValue / 84600) days"
                    }
                }
            }
        }
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

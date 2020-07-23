//
//  DescriptionViewController.swift
//  ToDoList
//
//  Created by Никита Плахин on 7/21/20.
//  Copyright © 2020 Никита Плахин. All rights reserved.
//

import UIKit
import CoreData

class TaskCreationViewController: UIViewController {

    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var taskDeadline: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
    weak var parentVC: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.accessibilityIdentifier = "creationView"
        self.taskTitle.accessibilityIdentifier = "creationTitleTextField"
        self.taskDeadline.accessibilityIdentifier = "creationDeadlineDatePicker"
        self.saveButton.accessibilityIdentifier = "creationSaveButton"
        
        
        // Do any additional setup after loading the view.
    }


    @IBAction func saveTask(_ sender: Any) {
        if taskTitle.text != "" {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "ToDoItem", in: context)!
            let task = NSManagedObject(entity: entity, insertInto: context)
            task.setValue(taskTitle.text, forKey: "title")
            task.setValue(false, forKey: "status")
            task.setValue(taskDeadline.date, forKey: "deadline")
            
            do {
                try context.save()
                parentVC?.todoItems.append(task)
                parentVC?.fetchToDoItems()
            } catch {
                fatalError("Error in saving")
            }
            parentVC?.tableView?.reloadData()
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
//    @objc func hide() {
//        self.view.endEditing(true)
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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

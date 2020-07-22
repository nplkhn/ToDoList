//
//  ViewController.swift
//  ToDoList
//
//  Created by Никита Плахин on 7/18/20.
//  Copyright © 2020 Никита Плахин. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ChangeButton {
    var tableView: UITableView? = nil
    var todoItems: [NSManagedObject] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupViews()
        fetchToDoItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "TODO Items"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(self.addToDoItem))
    }

    private func setupViews() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView?.translatesAutoresizingMaskIntoConstraints = false
        if let tableView = tableView {
            view.addSubview(tableView)
        }
        
        tableView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        tableView?.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "ToDoItemCell")
        
        tableView?.delegate = self
        tableView?.dataSource = self
    }
    
    func fetchToDoItems() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ToDoItem")
        let descriptor = NSSortDescriptor(key: "deadline", ascending: true)
        fetchRequest.sortDescriptors = [descriptor]
        do {
            todoItems = try context.fetch(fetchRequest)
        } catch {
            fatalError("Failed to fetch items")
        }
    }
    
    
    // MARK: table view delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) as! TableViewCell
        cell.todoItems = todoItems
        cell.index = indexPath.row
        cell.delegate = self
        
        let task = todoItems[indexPath.row]
        cell.taskTitle.text = task.value(forKey: "title") as? String
        if task.value(forKey: "status") as? Int == 0 {
            cell.taskStatus.setImage(UIImage(systemName: "square"), for: .normal)
            cell.taskStatus.tintColor = .darkGray
        } else {
            cell.taskStatus.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            cell.taskStatus.tintColor = UIColor(red: 27.0/255.0, green: 135.0/255.0, blue: 72.0/255.0, alpha: 1)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let context = appDelegate?.persistentContainer.viewContext
            context?.delete(todoItems[indexPath.row])
            todoItems.remove(at: indexPath.row)
            
            do {
                try context?.save()
            } catch {
                fatalError("Failed to delete item")
            }
            
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let descriptionVC = DescriptionViewController()
        descriptionVC.managedObject = todoItems[indexPath.row]
        
        self.present(descriptionVC, animated: true, completion: nil)
        print((todoItems[indexPath.row].value(forKey: "status"))!)
        
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
    }
    
    // MARK: button actions
    
    @objc func addToDoItem() {
        
        let creationViewController = TaskCreationViewController(nibName: "TaskCreationViewController", bundle: nil)
        creationViewController.parentVC = self
        
        self.present(creationViewController, animated: true, completion: nil)
        
    }
    
    func toggleStatus(status: Bool, index: Int?) {
        todoItems[index!].setValue(status, forKey: "status")
        do {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            try context.save()
        } catch {
            fatalError("Error in saving")
        }
        tableView?.reloadData()
    }
    
}


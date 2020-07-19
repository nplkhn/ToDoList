//
//  ViewController.swift
//  ToDoList
//
//  Created by Никита Плахин on 7/18/20.
//  Copyright © 2020 Никита Плахин. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView? = nil
    var todoItems: [NSManagedObject]? = []
    var titleTextField: UITextField!
    

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
    
    func titleTextField(textField: UITextField!) {
        titleTextField = textField
        titleTextField.placeholder = "TODO:"
    }
    
    func fetchToDoItems() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ToDoItem")
        do {
            todoItems = try context.fetch(fetchRequest)
        } catch {
            fatalError("Failed to fetch items")
        }
    }
    
    
    // MARK: table view delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) as! TableViewCell
        let task = todoItems?[indexPath.row]
        if let task = task {
            cell.taskTitle.text = task.value(forKey: "title") as? String
        }
        return cell
    }
    
    
    // MARK: button actions
    
    @objc func addToDoItem() {
        let alert = UIAlertController(title: "Add TODO", message: "Add your item name below", preferredStyle: .alert)
        let add = UIAlertAction(title: "Save", style: .default, handler: self.add)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(add)
        alert.addAction(cancel)
        alert.addTextField(configurationHandler: titleTextField)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func add(sender: UIAlertAction!) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ToDoItem", in: context)!
        let task = NSManagedObject(entity: entity, insertInto: context)
        task.setValue(titleTextField.text, forKey: "title")
        task.setValue(false, forKey: "status")
        task.setValue(Date(), forKey: "createdAt")
        
        do {
            try context.save()
            todoItems?.append(task)
        } catch {
            fatalError("Error in saving")
        }
        tableView?.reloadData()
    }
    
}


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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "TODO Items"
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
    
    
    // MARK: table view delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) as! TableViewCell
        
        return cell
        
    }
    
}


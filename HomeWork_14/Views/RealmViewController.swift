//
//  RealmViewController.swift
//  HomeWork_14
//
//  Created by Alexey Peshekhonov on 17.07.2020.
//  Copyright © 2020 Alexey Peshekhonov. All rights reserved.
//

import UIKit
import RealmSwift

class RealmViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    var tasks: Results<RealmTodoListModel>!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tasks = realm.objects(RealmTodoListModel.self)
    }
    
//MARK: -Actions
    
    @IBAction func addTaskButton(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Add new task", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "task"
        }
        
        let addButton = UIAlertAction(title: "Add", style: .default) { (action) in
            let text = alertController.textFields?.first?.text
            if text != "" {
                let newTask = RealmTodoListModel(task: text!)
                try! self.realm.write {
                    self.realm.add(newTask)
                }
                self.tableView.reloadData()
            } else {
                self.addTaskButton(self)
            }
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(addButton)
        alertController.addAction(cancelButton)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}

//MARK: -Extensions

extension RealmViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks == nil ? 0 : tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = tasks[indexPath.row].task
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! self.realm.write {
                self.realm.delete(tasks[indexPath.row])
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

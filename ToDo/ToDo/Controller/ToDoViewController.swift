//
//  ViewController.swift
//  ToDo
//
//  Created by Hrishav on 19/11/21.
//

import UIKit

class ToDoViewController: UIViewController {

    @IBOutlet weak var todoTableView: UITableView!
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    var todos: [TodoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        }
    
    func setupNavigationBar(){
        
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Notes", style: .plain, target: self, action: #selector(addNotesButtonTapped))
        
    navigationItem.rightBarButtonItem?.tintColor = .black
        
    }
    
    @objc func addNotesButtonTapped(){
        
        let alert = UIAlertController(title: "Enter Your to do item", message: "", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.text = "To Do: "
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            
            guard let textField = alert?.textFields?[0] else{
                return
            }
            
            guard let textValue = textField.text else {
                return
            }
            
             let todoitem = TodoItem(taskName: textValue)
            
            self.todos.append(todoitem)
            
            self.todoTableView.reloadData()
            
        }))
       
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension ToDoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (todos.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let item = todos[indexPath.row]
        let cell = todoTableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoTableViewCell
        cell.taskToDoLabel.text = item.taskName
        cell.createdDateLabel.text = "\(item.dateCreated)"
        return cell
    
    }
    
}
    
extension ToDoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = todos[indexPath.row]
        
        let detailviewcontroller = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! ToDoDetailViewController
        detailviewcontroller.titleLabel = item.taskName
        detailviewcontroller.dateCreated = "\(item.dateCreated)"
        detailviewcontroller.dateEnded = "\(item.dateCompleted)"

        self.present(detailviewcontroller, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
      return true
   }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
       let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
           DispatchQueue.main.async {
               self.todoTableView.reloadData()
           }
           let alert = UIAlertController(title: "", message: "Edit list item", preferredStyle: .alert)
           alert.addTextField(configurationHandler: { (textField) in
               textField.text = self.todos[indexPath.row].taskName
               
           })
           alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { (updateAction) in
               self.todos[indexPath.row].taskName = alert.textFields!.first!.text!
              // self.todoTableView.reloadRows(at: [indexPath], with: .fade)
               self.todoTableView.reloadData()
              
           }))
           alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
           self.present(alert, animated: false)
       })

       let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
           self.todos.remove(at: indexPath.row).taskName 
           DispatchQueue.main.async {
               self.todoTableView.reloadData()
           }
      
       })

       return [deleteAction, editAction]
   }
    
    


}

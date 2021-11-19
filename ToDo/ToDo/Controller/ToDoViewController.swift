//
//  ViewController.swift
//  ToDo
//
//  Created by Hrishav on 19/11/21.
//

import UIKit
import CloudKit

class ToDoViewController: UIViewController {

    @IBOutlet weak var todoTableView: UITableView!
    
    @IBOutlet weak var navigationBar: UINavigationItem!
   

    
    
    
    var todoItem:TodoItem = TodoItem()

    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        
        todoItem = TodoItem()
        
        setupNavigationBar()
        
        
    }

    
    func setupNavigationBar(){
        
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Notes", style: .plain, target: self, action: #selector(addNotesButtonTapped))
    navigationItem.rightBarButtonItem?.tintColor = .black
        
    }
    
    @objc func addNotesButtonTapped(){
        
        let alert = UIAlertController(title: "Enter Your to do item", message: "", preferredStyle: .alert)

      
        alert.addTextField { (textField) in
            textField.text = "to do: "
        }

        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            let textValue = textField?.text
            
           
            
           
            self.todoItem.dateCreated.append(self.currentDate())
            self.todoItem.taskName.append(textValue!)
            
            UserDefaults.standard.set(self.todoItem.taskName, forKey: "defaultKey")
            UserDefaults.standard.set(self.todoItem.dateCreated, forKey: "currentDate")
            
            
            self.todoTableView.reloadData()
        }))

       
        self.present(alert, animated: true, completion: nil)
    }
    
    
   
    
}

extension ToDoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func currentDate() -> String{
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateToString = dateFormatter.string(from: date)
        return dateToString
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (todoItem.taskName.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        let cell = todoTableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoTableViewCell
        
    
        if let arrayOfText =  UserDefaults.standard.array(forKey: "defaultKey") {
        
            cell.taskToDoLabel.text = arrayOfText[indexPath.row] as! String
            
        }
      if  let dateCreated =  UserDefaults.standard.array(forKey: "currentDate")  {
            
          cell.createdDateLabel.text = dateCreated[indexPath.row] as! String
        }
        
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! TODODetailViewController
        vc.detailLabel = todoItem.taskName[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
      return true
   }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
       let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
           let alert = UIAlertController(title: "", message: "Edit list item", preferredStyle: .alert)
           alert.addTextField(configurationHandler: { (textField) in
               textField.text = self.todoItem.taskName[indexPath.row]
           })
           alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { (updateAction) in
               self.todoItem.taskName[indexPath.row] = alert.textFields!.first!.text!
               self.todoTableView.reloadRows(at: [indexPath], with: .fade)
           }))
           alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
           self.present(alert, animated: false)
       })

       let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
           self.todoItem.taskName.remove(at: indexPath.row)
           tableView.reloadData()
       })

       return [deleteAction, editAction]
   }
    
}


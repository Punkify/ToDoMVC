//
//  TODODetailViewController.swift
//  ToDo
//
//  Created by Hrishav on 19/11/21.
//

import UIKit

class ToDoDetailViewController: UIViewController {

    @IBOutlet weak var todoDetailLabel: UILabel!
    
    @IBOutlet weak var dateCreatedLabel: UILabel!
    
    @IBOutlet weak var isCompleted: UISwitch!
    
    @IBOutlet weak var dateEndedLabel: UILabel!
    
    var titleLabel: String = ""
    
    var dateCreated: String = ""
    
    var dateEnded: String = ""
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        todoDetailLabel.text = titleLabel
        dateCreatedLabel.text = dateCreated
       
    }
    
  
    
    @IBAction func switchProgress(_ sender: Any) {
        
        if isCompleted.isOn == true {
            
            dateEndedLabel.text = dateEnded
            
        }
        
        else {
            
        dateEndedLabel.text = "In Progress"
            
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

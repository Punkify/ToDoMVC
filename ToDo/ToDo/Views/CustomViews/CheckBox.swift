//
//  CheckBox.swift
//  ToDo
//
//  Created by Hrishav on 19/11/21.
//

import UIKit



class CheckBox: UIButton, InformingDelegate {
    

    
    var changedDate:String = ""
    
    
    
    func valueChanged(_ newString:String) -> String {
        
        changedDate = newString
        
        print("value changed", changedDate)
        
        return  changedDate
     
        
            }
    
    
   
    
    
    
    let checkedImage = UIImage(named: "ic_check_box")! as UIImage
     let uncheckedImage = UIImage(named: "ic_check_box_outline_blank")! as UIImage
     
     // Bool property
     var isChecked: Bool = false {

         didSet {
          
             if isChecked == true {
                 let vc1 = ToDoViewController()
                 changedDate = vc1.currentDate()
                 
                 valueChanged(changedDate)
                 vc1.dateEnded = changedDate
                
              
                 self.setImage(checkedImage, for: UIControl.State.normal)
                 
                 
                
                
             } else {
                 changedDate = ""
                 valueChanged(changedDate)
                 self.setImage(uncheckedImage, for: UIControl.State.normal)
             }
         }
     }
         
     override func awakeFromNib() {
         self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
         self.isChecked = false
     }
         
     @objc func buttonClicked(sender: UIButton) {
         if sender == self {
             isChecked = !isChecked
         }
     }

   
     func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNextVC" {
            
             let vc = segue.destination as! ToDoViewController
            vc.dateEnded = changedDate
        }
    }
}

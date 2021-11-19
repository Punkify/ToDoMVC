//
//  TODODetailViewController.swift
//  ToDo
//
//  Created by Hrishav on 19/11/21.
//

import UIKit

class TODODetailViewController: UIViewController {

    @IBOutlet weak var todoDetailLabel: UILabel!
    
    var detailLabel: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        todoDetailLabel.text = detailLabel
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

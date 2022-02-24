//
//  AddTodoVC.swift
//  Todo List
//
//  Created by Võ Trí on 11/02/2022.
//

import UIKit
import CoreData

protocol AddTodoProtocol {
    func sendTodoFromVC(_ todo:String)
}

class AddTodoVC: UIViewController {
    
    // MARK: - IB Outlet
    @IBOutlet weak var todoTextField: UITextField!
    
    
    //MARK: - Properties
    var delegate: AddTodoProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - IB Action
    
    @IBAction func tappedAddTodo(_ sender: UIButton) {
        if let todo = todoTextField.text {
//            delegate?.sendTodoFromVC(todo)
            dismiss(animated: true) {
                self.delegate?.sendTodoFromVC(todo)
            }
        } else {
            return
        }
        
        
    }
    
    // MARK: - Methods
    
    
}

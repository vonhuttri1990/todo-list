//
//  TodoListVC.swift
//  Todo List
//
//  Created by Võ Trí on 11/02/2022.
//

import UIKit
import CoreData


class TodoListVC: UIViewController {
    
    // MARK: IB Outlet
    @IBOutlet weak var todoTableView: UITableView!
    
    
    // MARK: - Properties
    private var todos = [NSManagedObject]() {
        didSet {
        
            // reload table after changes todos array
            OperationQueue.main.addOperation {
                self.todoTableView.reloadData()
            }
        }
    }
    var navTitle = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoTableView.register(UINib(nibName: "TodoCell", bundle: nil), forCellReuseIdentifier: "TodoCell")
        todoTableView.dataSource = self
        todoTableView.delegate = self
        
        self.navigationItem.title = navTitle
        loadDataFromCoreData()
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "popoverAddTodo" {
            if let addTodoVC = segue.destination as? AddTodoVC {
            addTodoVC.delegate = self
            }
        }
    }
}

// MARK: - todoTableview implementation datasource
extension TodoListVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: TodoCell = tableView.dequeueReusableCell(withIdentifier: "TodoCell") as? TodoCell {
            let todo = todos[indexPath.row]
            cell.todoLabel.text = todo.value(forKey: "name") as? String
            cell.detailTextLabel?.text = todo.value(forKey: "status") as? String
//            print(todo.value(forKey: "status"))
            
            cell.btnPressed = {
                print("AKD")
            }
            return cell
            
            
        }
        
        return UITableViewCell()
        }
}

// MARK: todoTableView implemtation delegate
extension TodoListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete) {
            let id = indexPath.row
            removeToDoCoreData(at: id)
            
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
           
        } else if editingStyle == .insert {
            
        }
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let cell: TodoCell = tableView.dequeueReusableCell(withIdentifier: "TodoCell") as? TodoCell {
//            cell.btnPressed = {
//                print("ABC")
//            }
//        }
//
//    }
}

// MARK: - Implentation AddTodoProtocol get back data
extension TodoListVC: AddTodoProtocol {
    
    func sendTodoFromVC(_ todo: String) {
        self.save(coreDate: todo)
    }
}

// MARK: - Core Data stack
extension TodoListVC {
    func save(coreDate withTodo: String, status: Bool = false) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Todo", in: managedContext)!
        let todo = NSManagedObject(entity: entity, insertInto: managedContext)
        todo.setValue(withTodo, forKey: "name")
        todo.setValue(status, forKey: "status")
        
        do {
            try managedContext.save()
            loadDataFromCoreData()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func loadDataFromCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Todo")
        
        do {
            todos = try managedContext.fetch(fetchRequest)
            
        } catch let err as NSError {
            print("Could not fetch. \(err), \(err.userInfo)")
        }
    }
    
    func removeToDoCoreData(at id: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let todoToDelete = todos[id]
        managedContext.delete(todoToDelete)
        
        do {
            try managedContext.save()
        } catch  let err as NSError {
            print("Could not save. \(err), \(err.userInfo)")
        }
    }
}

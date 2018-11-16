//
//  ViewTodoViewController.swift
//  todo-app
//
//  Created by Michael Florendo on 09/11/2018.
//  Copyright © 2018 Michael Florendo. All rights reserved.
//

import UIKit
import CoreData

class ViewTodoViewController: UIViewController {

    //MARK: - Properties
    var presenter : HomePresenter?
    @IBOutlet weak var todoStatus: UILabel!
//    @IBOutlet weak var todoDate: UILabel!
    @IBOutlet weak var todoTitle: UILabel!
    @IBOutlet weak var buttonDelete: UIButton!
    
    var todo = Todo()
    var realmTodo = RealmTodo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = HomePresenter(delegate: self)
        buttonDelete.isEnabled = true
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-dd-MM"
//
//        todoTitle.text = todo.title
//        todoStatus.text = todo.status == true ? "Done" : "Not Done"
//        todoDate.text = dateFormatter.string(from: todo.date)
        
        todoTitle.text = realmTodo.task
        todoStatus.text = realmTodo.status == true ? "Done" : "Not Done"
    }
    
    //MARK: - Actions
    @IBAction func barButtonBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonDeleteTapped(_ sender: Any) {
//        deleteTodo()
        buttonDelete.isEnabled = false
        let isDeleted = self.presenter?.realmDeleteTodo(todo: realmTodo)
        if isDeleted == true {
            dismiss(animated: true, completion: nil)
        }
    }

    //MARK: - Private Functions
//    private func toggleTodoStatus() {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//        let request : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Todos")
////        request.predicate = NSPredicate(format: "username", "")
//
//        do {
//            let test = try context.fetch(request)
//
//            let objectUpdate = test[0] as! NSManagedObject
//            objectUpdate.setValue(true, forKey: "status")
//            do {
//                try context.save()
//            } catch {
//                print("Error:\(error)")
//            }
//        } catch {
//            print("Can't update record")
//        }
//    }
//
//    private func deleteTodo() {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Todos")
//
//        do {
//            let test = try context.fetch(request)
//            let objectToDelete = test[0] as! NSManagedObject
//            context.delete(objectToDelete)
//            print("Record Deleted")
//
//            do {
//                try context.save()
//            } catch {
//                print("Error \(error)")
//            }
//
//        } catch {
//            print("Error \(error)")
//        }
//    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ViewTodoViewController: HomeDelegate {
    func operationResult(message: String) {
        print(message)
    }
}

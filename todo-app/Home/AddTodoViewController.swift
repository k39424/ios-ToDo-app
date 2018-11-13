//
//  AddTodoViewController.swift
//  todo-app
//
//  Created by Michael Florendo on 13/11/2018.
//  Copyright © 2018 Michael Florendo. All rights reserved.
//

import UIKit
import CoreData

class AddTodoViewController: UIViewController {

    //MARK: Properties
    var todo = Todo()
    @IBOutlet weak var textFieldTodo: UITextField!
    @IBOutlet weak var datePickerTodo: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Actions
    
    @IBAction func buttonCancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonSaveTapped(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-dd-MM"
        dateFormatter.timeStyle = .none
        
        let todoTitle = textFieldTodo.text ?? ""
        let todoDate = datePickerTodo.date
        print("Date Value: \(todoDate)")

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
//        let entity = NSEntityDescription.entity(forEntityName: "Todos", in: context)
        
        let entity = NSEntityDescription.entity(forEntityName: "Todos", in: context)
        
        let newTodo = NSManagedObject(entity: entity!, insertInto: context)
        newTodo.setValue(todoTitle, forKey:"title")
        newTodo.setValue(todoDate, forKey: "date")
        newTodo.setValue(false, forKey:"status")
        
        do {
            try context.save()
        } catch {
            print("Cant save todo")
        }
        dismiss(animated: true, completion: nil)
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

//
//  HomeTableViewController.swift
//  todo-app
//
//  Created by Michael Florendo on 09/11/2018.
//  Copyright © 2018 Michael Florendo. All rights reserved.
//

import UIKit
import CoreData

class HomeTableViewController: UITableViewController {

    //MARK: - Properties
    var todos = [Todo]()
    var selectedTodo = Todo()
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Hello \(user.email)")
        generateTodos()
//        addTodosToCoreData()
        getTodosFromCoreData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func barButtonBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-dd-MM"
        
        let identifier = "TodoTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
            as? TodoTableViewCell else {
                fatalError("Cell is not TodoTableViewCell")
        }
        
        let todo = todos[indexPath.row]
        cell.todoStatus.text = todo.status == true ? "Done" : "Not Done"
        cell.todoDate.text = dateFormatter.string(from: todo.date)
        cell.todoTitle.text = todo.title

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation
*/
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nc = segue.destination as? UINavigationController
        
        if  let vc = nc?.topViewController as? ViewTodoViewController {
            let path = self.tableView.indexPathForSelectedRow
            vc.todo = todos[path!.row]
        }
        
        
//
//        if let vc = segue.destination as? ViewTodoViewController {
//            let path = self.tableView.indexPathForSelectedRow
//            print("@ViewTodoController")
//            selectedTodo = todos[path!.row]
//            print("TODO: \(selectedTodo.title)")
//            vc.todo = selectedTodo
//        } else {
//
//        }
    }
    
    
    //MARK: - Dummy Data Functions
    
    func dateRandomizer()->Date {
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        let monthValue = Int.random(in: month..<12)
        let dayValue = Int.random(in: day..<30)
        
        let dateString = "\(year)-\(dayValue)-\(monthValue)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "yyyy-dd-MM"
        print("Generated Date: \(dateFormatter.date(from: dateString)!)")
        return dateFormatter.date(from: dateString)!
    }
    
    func generateTodos() {
        todos.append(Todo( status: true, date: dateRandomizer(), title: "Milk is gatas"))
        todos.append(Todo( status: false, date: dateRandomizer(), title: "Hello World"))
        todos.append(Todo( status: true, date: dateRandomizer(), title: "Hello from Another World"))
        todos.append(Todo( status: false, date: dateRandomizer(), title: "Buy Batteries"))
        todos.append(Todo( status: true, date: dateRandomizer(), title: "Sleep"))
        todos.append(Todo( status: true, date: dateRandomizer(), title: "I Dont Know"))
        todos.append(Todo( status: false, date: dateRandomizer(), title: "Do Nothing"))
        todos.append(Todo( status: true, date: dateRandomizer(), title: "QWE"))
    }

    private func addTodosToCoreData() {
        generateTodos()
        
        for todo in todos {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "Todos", in: context)
            let newTodo = NSManagedObject(entity: entity!, insertInto: context)
            
            newTodo.setValue(todo.title, forKey: "title")
            newTodo.setValue(todo.date, forKey: "date")
            newTodo.setValue(todo.status, forKey: "status")
        
            do {
                try context.save()
                print("Todo Saved")
                print("Date: \(todo.date)")
            } catch {
                print("Cant save tasks")
            }
        }
    }
    
    private func getTodosFromCoreData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Todos")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            
            for data in result as! [NSManagedObject] {
                todos.append(Todo(status: data.value(forKey: "status") as? Bool, date: data.value(forKey: "date") as? Date, title: data.value(forKey: "title") as? String))
            }
        } catch {
            print("Fetching Todos Failed")
        }
    }
    
}

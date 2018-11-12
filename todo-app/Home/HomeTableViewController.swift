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
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Hello \(user.email)")
        generateTodos()
        
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
        /*let cellIdentifier = "Cell"
         guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
         as? QuoteTableViewCell else {
         fatalError("The dequeued cell is not an instance of QuoteTableViewCell.")
         }
         //        Fetches the appropriate quote for the data source layout
         let qoute = quotesArray[indexPath.row]
         
         cell.messageLabel.text = qoute.message
         cell.authorMessage.text = qoute.author
         
         return cell*/
        
        let identifier = "TodoTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
            as? TodoTableViewCell else {
                fatalError("Cell is not TodoTableViewCell")
        }
        
        let todo = todos[indexPath.row]
        cell.todoStatus.text = "Done"
        cell.todoDate.text = todo.date
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
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//    }
    
    
    func generateTodos() {
        todos.append(Todo(id: "1", status: true, date: "2018-11-08", title: "Milk is gatas", description: "Buy Milk"))
        todos.append(Todo(id: "2", status: false, date: "2018-11-09", title: "Hello World", description: "Say Hello to World"))
        todos.append(Todo(id: "3", status: true, date: "2018-11-08", title: "Hello from Another World", description: "Say Hello to Another World"))
        todos.append(Todo(id: "4", status: false, date: "2018-12-10", title: "Buy Batteries", description: "Out of Batteries buy 1"))
        todos.append(Todo(id: "5", status: true, date: "2018-10-20", title: "Sleep", description: "Sleep"))
        todos.append(Todo(id: "6", status: true, date: "2018-11-05", title: "I Dont Know", description: "I Also Dont know"))
        todos.append(Todo(id: "7", status: false, date: "2018-12-05", title: "Do Nothing", description: "This is where Im good at"))
        todos.append(Todo(id: "8", status: true, date: "2018-11-05", title: "Eat", description: "Eat"))
    }

    private func addTodosToCoreData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Todos", in: context)
        let newTodo = NSManagedObject(entity: entity!, insertInto: context)
        
        for todo in todos {
            newTodo.setValue(todo.id, forKey: "id")
            newTodo.setValue(todo.title, forKey: "title")
            newTodo.setValue(todo.description, forKey: "description")
            newTodo.setValue(todo.status, forKey: "status")
        }
        
        do {
            try context.save()
        } catch {
            print("Cant save tasks")
        }
    }
    
    //adding dummy users to core data
//    private func addToCoreData(user: User) {
//        //create delegate
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        //create context
//        let context = appDelegate.persistentContainer.viewContext
//        //create entity(it seems the a entity = table of database and columns are properties)
//        let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
//        //like create an object with properties coming from the entity
//        let newUser = NSManagedObject(entity: entity!, insertInto: context)
//        //add values
//        newUser.setValue("1", forKey: "id")
//        newUser.setValue("firstUser", forKey: "name")
//        newUser.setValue("firstUser@email.com", forKey: "email")
//        newUser.setValue("firstUser", forKey: "password")
//        newUser.setValue(false, forKey: "isLoggedIn")
//
//        do {
//            try context.save()
//        } catch {
//            print("Failed saving to Core Data")
//        }
//    }
    
    private func getTodosFromCoreData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Todos")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "title") as! String)
            }
        } catch {
            print("Fetching Todos Failed")
        }
    }
    
    //fetching data from the core data
//    private func getFromCoreData() {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        //create context
//        let context = appDelegate.persistentContainer.viewContext
//        //request that we will make to access the data from core data
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
//        request.returnsObjectsAsFaults = false
//        do {
//            let result = try context.fetch(request)
//            for data in result as! [NSManagedObject] {
//                print(data.value(forKey: "email") as! String)
//            }
//
//        } catch {
//            print("Failed")
//        }
//    }
}

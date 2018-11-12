//
//  HomeTableViewController.swift
//  todo-app
//
//  Created by Michael Florendo on 09/11/2018.
//  Copyright © 2018 Michael Florendo. All rights reserved.
//

import UIKit

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
        todos.append(Todo(id: "1", status: true, date: "2018-11-08", title: "Hello World"))
        todos.append(Todo(id: "2", status: false, date: "2018-11-09", title: "Hello from World"))
        todos.append(Todo(id: "3", status: true, date: "2018-11-08", title: "Hello from Another World"))
        todos.append(Todo(id: "4", status: false, date: "2018-12-10", title: "Another Hello World"))
        todos.append(Todo(id: "5", status: true, date: "2018-10-20", title: "Hello Another World"))
        todos.append(Todo(id: "6", status: true, date: "2018-11-05", title: "Another Hello Another World"))
        todos.append(Todo(id: "7", status: false, date: "2018-12-05", title: "New Hello World"))
        todos.append(Todo(id: "8", status: true, date: "2018-11-05", title: "New Another Hello World"))
        
        for todo in todos {
            print("ID: \(todo.id)")
            print("Title: \(todo.title)")
            print("Status: \(todo.status)")
        }
    }

}

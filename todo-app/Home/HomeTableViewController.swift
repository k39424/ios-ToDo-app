//
//  HomeTableViewController.swift
//  todo-app
//
//  Created by Michael Florendo on 09/11/2018.
//  Copyright © 2018 Michael Florendo. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class HomeTableViewController: UITableViewController {
    //MARK: - Properties
    var todos = [Todo]()
    var selectedTodo = Todo()
    var user = User()
    var itemsToken : NotificationToken?
    var presenter : HomePresenter?
    var todoList : Results<RealmTodo>? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = HomePresenter(delegate: self)
        print("Hello \(user.email)")
        getTodos()
//        generateTodos()
//        addTodosToCoreData()
//        getTodosFromCoreData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        itemsToken = todoList?.observe { [weak tableView] changes in
        guard let tableView = tableView else { return }
            switch changes {
                case .initial:
                    tableView.reloadData()
                    break
                case .update(_, let deletions, let insertions, let updates):
                    let fromRow = {(row: Int) in
                        return IndexPath(row: row, section: 0)}
//                    tableView.reloadData()
//                    print("Row Index= \(fromRow)")
                    tableView.deleteRows(at: deletions.map(fromRow), with: .automatic)
                    tableView.insertRows(at: insertions.map(fromRow), with: .automatic)
                    tableView.reloadRows(at: updates.map(fromRow), with: .automatic)
                break
                
//                    tableView.applyChanges(deletions: deletions, insertions: insertions, updates: updates)
                default: break
                self.itemsToken?.invalidate()
            }
        }
        
//        case .update(_, let deletions, let insertions, let updates):
//        let fromRow = {(row: Int) in
//            return IndexPath(row: row, section: 0)}
//
//        beginUpdates()
//        deleteRows(at: deletions.map(fromRow), with: .automatic)
//        insertRows(at: insertions.map(fromRow), with: .automatic)
//        reloadRows(at: updates.map(fromRow), with: .none)
//        endUpdates()
        
        
        /*itemsToken = items?.observe { [weak tableView] changes in
         guard let tableView = tableView else { return }
         
         switch changes {
         case .initial:
         tableView.reloadData()
         case .update(_, let deletions, let insertions, let updates):
         tableView.applyChanges(deletions: deletions, insertions: insertions, updates: updates)
         case .error: break
         }
         }*/
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
        return todoList?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-dd-MM"
        
        print("At TableView")
        let identifier = "TodoTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
            as? TodoTableViewCell else {
                fatalError("Cell is not TodoTableViewCell")
        }
        
//        let todo = todos[indexPath.row]
//        cell.todoStatus.text = todo.status == true ? "Done" : "Not Done"
//        cell.todoDate.text = dateFormatter.string(from: todo.date)
//        cell.todoTitle.text = todo.title
        let todo = todoList?[indexPath.row]
        cell.delegate = self
        
        cell.todoTitle.text = todo?.task
        cell.todoStatus.text = todo?.status == true ? "Done" : "Not Done"

        if todo?.status == true {
            cell.buttonStatus.setImage(#imageLiteral(resourceName: "checkbox-checked-48px"), for: .normal)
        } else {
            cell.buttonStatus.setImage(#imageLiteral(resourceName: "checkbox-unchecked-48px"), for: .normal)
        }
        
        return cell
    }
    
    private func showDialog(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            NSLog("Ok", [])
        }
        
        //        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (UIAlertAction) in
        //            NSLog("Cancel", [])
        //        }
        
        alertController.addAction(okAction)
        //        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    //adding dummy users to core data
    private func addToCoreData(user: User) {
        //create delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //create context
        let context = appDelegate.persistentContainer.viewContext
        //create entity(it seems the a entity = table of database and columns are properties)
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
        //like create an object with properties coming from the entity
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        //add values
        newUser.setValue("1", forKey: "id")
        newUser.setValue("firstUser", forKey: "name")
        newUser.setValue("firstUser@email.com", forKey: "email")
        newUser.setValue("firstUser", forKey: "password")
        newUser.setValue(false, forKey: "isLoggedIn")
        
        do {
            try context.save()
        } catch {
            print("Failed saving to Core Data")
        }
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
//            vc.todo = todos[path!.row]
            vc.realmTodo = (todoList?[path!.row])!
//            vc.realmTodo = ((todoList?[(path?.row)!])!)
        } else if let avc = nc?.topViewController as? AddTodoViewController {
            self.itemsToken?.invalidate()
        }
    }
    
    //MARK: Private Functions
    private func getTodos() {
        todoList = self.presenter?.realmGetTodos()
        for getTodo in todoList! {
            print("Todo: \(getTodo.task)")
        }
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

extension HomeTableViewController: HomeDelegate {
    func operationResult(message: String) {
        print(message)
    }
}

extension HomeTableViewController: TodoCellDelegate {
    func todoStatusToggle(_ sender: TodoTableViewCell) {
        guard let tappedIndexPath = tableView.indexPath(for: sender) else { return }
        let todoToEdit = todoList![tappedIndexPath.row]
        let newStatus = !todoList![tappedIndexPath.row].status
        print("Todo To Toggle: \(todoToEdit.task) Status: \(todoToEdit.status)")
        
        print("New Status: \(newStatus)")
        print("Cell Clicked @ViewController", sender, tappedIndexPath)
        
         let isToggled = self.presenter?.realmToggleStatus(todo: todoToEdit, status: newStatus)
        if isToggled == true {
            
            let cell = self.tableView.cellForRow(at: tappedIndexPath) as! TodoTableViewCell
            if newStatus == true {
                print("Toggling to Checked")
//                cell.buttonStatus.setImage(#imageLiteral(resourceName: "checkbox-checked-48px"), for: .normal)
            } else {
                print("Toggling to UnChecked")
//                cell.buttonStatus.setImage(#imageLiteral(resourceName: "checkbox-unchecked-48px"), for: .normal)
            }
            
        }
//        guard let tappedIndexPath = tableView.indexPath(for: sender) else { return }
//        print("Trash", sender, tappedIndexPath)
    }
}

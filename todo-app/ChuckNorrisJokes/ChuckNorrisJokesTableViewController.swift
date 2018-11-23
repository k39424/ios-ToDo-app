//
//  ChuckNorrisJokesTableViewController.swift
//  todo-app
//
//  Created by Michael Florendo on 19/11/2018.
//  Copyright © 2018 Michael Florendo. All rights reserved.
//

import UIKit
import SVProgressHUD

class ChuckNorrisJokesTableViewController: UITableViewController {

    var jokesList = [Joke]()
    var presenter : JokesPresenter?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        presenter = JokesPresenter(delegate: self)
        SVProgressHUD.show()
        self.presenter?.getJokes(query: "test")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    @IBAction func buttonBackTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokesList.count
    }
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "JokeCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
            as? JokeTableViewCell else {
                fatalError("The dequeued cell is not a joke")
        }
        
        cell.labelJoke.text = jokesList[indexPath.row].value

        // Configure the cell...

        return cell
    }
    
    func makeJokes() {
        jokesList.append(Joke(value: "Hello World"))
        jokesList.append(Joke(value: "Hello Another World"))
        jokesList.append(Joke(value: "Hello Another Another World"))
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ChuckNorrisJokesTableViewController: JokesDelegate {
    func operationResult(jokeList: Array<Joke>, message: String) {
        print(message)
        self.jokesList = jokeList
       self.tableView.reloadData()
        SVProgressHUD.dismiss()
    }
    
}

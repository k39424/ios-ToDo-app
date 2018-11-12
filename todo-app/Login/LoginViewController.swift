//
//  LoginViewController.swift
//  todo-app
//
//  Created by Michael Florendo on 08/11/2018.
//  Copyright © 2018 Michael Florendo. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    //MARK: - Properties
    var presenter : LoginPresenter?
    var email = ""
    var password = ""
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var buttonRegister: UIButton!
    @IBOutlet weak var buttonLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonRegister.layer.cornerRadius = 10
        buttonLogin.layer.cornerRadius = 10
        textFieldEmail.layer.cornerRadius = 10
        textFieldPassword.layer.cornerRadius = 10
        presenter = LoginPresenter(delegate: self)  //setup our presenter
        getFromCoreData()
    }
    
    //MARK: - Actions
    @IBAction func buttonLoginTapped(_ sender: UIButton) {
        email = textFieldEmail.text ?? ""
        password = textFieldPassword.text ?? ""
        let isLoggedIn = self.presenter?.login(email: email, password: password)
        if isLoggedIn == true {
            //create a new user object with the properties that we current get
            let user = User(id: "1", apiToken: "token", name: "User", email: email, password: password)
            //instantiate storyboard
            let homeStoryBoard = UIStoryboard(name: "Home", bundle: nil)
            
            //instantiate a view controller with of type HomeTableViewController
            //if does not fail set the user to our current user then present
            if let homeViewController = homeStoryBoard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeTableViewController {
                homeViewController.user = user
                self.present(homeViewController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func buttonRegisterTapped(_ sender: UIButton) {
        //used story board in here lol
    }
    
    /*
    // MARK: - Navigation
*/
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? HomeTableViewController {
            print("At Prepare")
            let user = User(id: "1", apiToken: "token", name: "User", email: email, password: password)
            vc.user = user
        }
    }
    
    
    //MARK: - Private Functions
    private func showDialog(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            NSLog("Ok", [])
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (UIAlertAction) in
            NSLog("Cancel", [])
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
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
    
    //fetching data from the core data
    private func getFromCoreData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //create context
        let context = appDelegate.persistentContainer.viewContext
        //request that we will make to access the data from core data
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "email") as! String)
            }
            
        } catch {
            print("Failed")
        }
    }
}

extension LoginViewController: LoginDelegate {
    func loginFailed(message: String) {
        print(message)
    }
    
    func loginSucceed(message: String) {
        print(message)
    }
}

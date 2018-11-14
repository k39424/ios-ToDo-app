//
//  RegisterViewController.swift
//  todo-app
//
//  Created by Michael Florendo on 08/11/2018.
//  Copyright © 2018 Michael Florendo. All rights reserved.
//

import UIKit
import RealmSwift

class RegisterViewController: UIViewController {

    //MARK: Properties
    var presenter : RegisterPresenter?
    var realm: Realm!
    var dbManager = DBManager()
//    var userList: Results<RealmUser> {
//        get {
//            return realm.objects(RealmUser.self)
//        }
//    }
    
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldConfirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = RegisterPresenter(delegate: self)
        realm = try! Realm()
        
//        let userList = realmGetUsers()
        
        let userList = self.presenter?.realmGetUsers()
        
        for user in userList! {
            print("User:")
            print(user.name)
            print(user.email)
        }
    }
    
    @IBAction func buttonRegisterTapped(_ sender: Any) {
        let email = textFieldEmail.text ?? ""
        let name = textFieldName.text ?? ""
        let password = textFieldPassword.text ?? ""
        let confirmPassword = textFieldConfirmPassword.text ?? ""
        
        let isValid = self.presenter?.register(name: name, email: email, password: password, confirmPassword: confirmPassword)
        
        if isValid == true {
            print("Success")
        }
        
        let newUser = RealmUser()
        newUser.name = name
        newUser.email = email
        newUser.password = password
        self.presenter?.realmAddUser(user: newUser)
//        realmAddUser(user: newUser)
    }
    
    @IBAction func buttonCancelTapped(_ sender: Any) {
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
    
    func realmAddUser(user: RealmUser) {
        try! self.realm.write {
            realm.add(user)
        }
        print("User \(user.name) was added")
    }
    
    func realmGetUsers()-> Results<RealmUser> {
        let results: Results<RealmUser> = realm.objects(RealmUser.self)
        return results
    }
    
}

extension RegisterViewController: RegisterDelegate {
    func registrationFailed(message: String) {
    }
    
    func registrationSuccess(message: String) {
        
    }
    
}

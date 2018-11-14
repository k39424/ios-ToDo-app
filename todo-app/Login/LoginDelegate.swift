//
//  LoginDelegate.swift
//  todo-app
//
//  Created by Michael Florendo on 08/11/2018.
//  Copyright © 2018 Michael Florendo. All rights reserved.
//

import Foundation
import RealmSwift

protocol LoginDelegate {
    func loginFailed(message: String)
    func loginSucceed(message: String)
}

class LoginPresenter {
    var delegate: LoginDelegate
    private var realm: Realm
    
    init(delegate: LoginDelegate) {
        self.delegate = delegate
        self.realm = try! Realm()
    }
    
    func login(email: String, password: String)->Bool {
        return true
    }
    
    //function will return three values
    //bool to return if input values are valid
    //RealmUser type if the entered user credentials is registered in db
    func userLogin(email: String, password: String)->(isValid: Bool,user: User) {
        var user = User()
        let userList = getAllRegisteredUsers()
        
        //check if user input is valid
        if email.isEmpty {
            self.delegate.loginFailed(message: "email can't be blank")
            return (false, user)
        }
        
        if password.isEmpty {
            self.delegate.loginFailed(message: "password can't be blank")
            return (false, user)
        }
        
        //iterate to users registered in db and check if inputted user creds exists
        for registeredUser in userList {
            print("User: \(registeredUser.name) \(registeredUser.email) \(registeredUser.password)")
            if user.email == registeredUser.email {
                print("User Found: \(registeredUser.name) \(registeredUser.email) \(registeredUser.password)")
                let loggedInUser = User(id: "testID", apiToken: "testApiToken",
                                        name: registeredUser.name, email: registeredUser.email,
                                        password: registeredUser.password)
                
                self.delegate.loginSucceed(message: "Welcome \(loggedInUser)")
                return (true, loggedInUser)
            }
        }
        
        self.delegate.loginSucceed(message: "No User Found")
        return (false, user)
    }
    
    func getAllRegisteredUsers()->Results<RealmUser> {
        let results: Results<RealmUser> = realm.objects(RealmUser.self)
        return results
    }
    
}


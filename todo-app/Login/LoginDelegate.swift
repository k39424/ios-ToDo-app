//
//  LoginDelegate.swift
//  todo-app
//
//  Created by Michael Florendo on 08/11/2018.
//  Copyright © 2018 Michael Florendo. All rights reserved.
//

import Foundation

protocol LoginDelegate {
    func loginFailed(message: String)
    func loginSucceed(message: String)
}

class LoginPresenter {
    var delegate: LoginDelegate
    
    init(delegate: LoginDelegate) {
        self.delegate = delegate
    }
    
    func login(email: String, password: String)->Bool {
        
        if email.isEmpty {
            self.delegate.loginFailed(message: "email can't be blank")
            return false
        }
        
        if password.isEmpty {
            self.delegate.loginFailed(message: "password can't be blank")
            return false
        }
        
        self.delegate.loginSucceed(message: "Login")
        return true
    }
    
    
}


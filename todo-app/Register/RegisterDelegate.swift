//
//  RegisterDelegate.swift
//  todo-app
//
//  Created by Michael Florendo on 08/11/2018.
//  Copyright © 2018 Michael Florendo. All rights reserved.
//

import Foundation

protocol RegisterDelegate {
//    func register(name: String, email: String, password: String)->String
    func registrationFailed(message: String)
    func registrationSuccess(message: String)
}

class RegisterPresenter {
    var delegate : RegisterDelegate?
    
    init(delegate: RegisterDelegate) {
        self.delegate = delegate
    }
    
    func register(name: String, email: String, password: String, confirmPassword: String)->Bool {
        if name.isEmpty {
            self.delegate?.registrationFailed(message: "name can't be empty")
            return false
        }

        if email.isEmpty {
            self.delegate?.registrationFailed(message: "email can't be empty")
            return false
        }

        if password.isEmpty {
            self.delegate?.registrationFailed(message: "password can't be empty")
            return false
        }
        
        if password != confirmPassword {
            self.delegate?.registrationFailed(message: "passwords do not match")
            return false
        }
        

        self.delegate?.registrationSuccess(message: "Welcome \(name)")
        return true
    }
    
}

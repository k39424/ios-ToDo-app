//
//  User.swift
//  todo-app
//
//  Created by Michael Florendo on 08/11/2018.
//  Copyright © 2018 Michael Florendo. All rights reserved.
//

import Foundation


struct User {
    let id: String
    let apiToken: String
    let name: String
    let email: String
    let password: String
    
    init(id: String? = nil, apiToken: String? = nil, name: String? = nil, email: String? = nil, password: String? = nil) {
        self.id = id ?? ""
        self.apiToken = apiToken ?? ""
        self.name = name ?? ""
        self.email = email ?? ""
        self.password = password ?? ""
    }
    
}

//
//  Todo.swift
//  todo-app
//
//  Created by Michael Florendo on 09/11/2018.
//  Copyright © 2018 Michael Florendo. All rights reserved.
//

import Foundation

struct Todo {
    let id: String
    let status: Bool
    let date: String
    let title: String
    
    
    init(id: String? = nil, status: Bool? = nil, date: String? = nil, title: String? = nil) {
        self.id = id ?? ""
        self.status = status ?? false
        self.date = date ?? ""
        self.title = title ?? ""
    }
}

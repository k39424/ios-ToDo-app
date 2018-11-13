//
//  Todo.swift
//  todo-app
//
//  Created by Michael Florendo on 09/11/2018.
//  Copyright © 2018 Michael Florendo. All rights reserved.
//

import Foundation

struct Todo {
    let status: Bool
    let date: Date
    let title: String
    
    
    init(status: Bool? = nil, date: Date? = nil, title: String? = nil) {
        self.status = status ?? false
        self.date = date ?? Date()
        self.title = title ?? ""
    }
}

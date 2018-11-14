//
//  RealmTodo.swift
//  todo-app
//
//  Created by Michael Florendo on 14/11/2018.
//  Copyright © 2018 Michael Florendo. All rights reserved.
//

import Foundation

class RealmTodo {
    @objc dynamic var task: String
    @objc dynamic var status: Bool
    
    init(task: String, status: Bool) {
        self.task = task
        self.status = status
    }
    
}

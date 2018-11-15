//
//  RealmTodo.swift
//  todo-app
//
//  Created by Michael Florendo on 14/11/2018.
//  Copyright © 2018 Michael Florendo. All rights reserved.
//

import Foundation
import RealmSwift

class RealmTodo: Object {
    @objc dynamic var task = ""
    @objc dynamic var status = false
    
//    init(task: String, status: Bool) {
//        self.task = task
//        self.status = status
//    }
}

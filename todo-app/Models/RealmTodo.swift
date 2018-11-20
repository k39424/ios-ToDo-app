//
//  RealmTodo.swift
//  todo-app
//
//  Created by Michael Florendo on 14/11/2018.
//  Copyright © 2018 Michael Florendo. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class RealmTodo: Object {
    @objc dynamic var task = ""
    @objc dynamic var status = false
    
//    init(task: String, status: Bool) {
//        self.task = task
//        self.status = status
//    }
    
//    required init?(map: Map) { }
    
//    required init() {
//        fatalError("init() has not been implemented")
//    }
    
//    mutating func mapping(map: Map) {
//        task <- map["value"]
//        status <- map["status"]
////        identifier <- map["id"]
////        language <- map["language"]
////        url <- map["url"]
//    }
}

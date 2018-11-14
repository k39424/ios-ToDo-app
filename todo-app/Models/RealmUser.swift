//
//  RealmUser.swift
//  todo-app
//
//  Created by Michael Florendo on 14/11/2018.
//  Copyright © 2018 Michael Florendo. All rights reserved.
//

import Foundation
import RealmSwift

class RealmUser : Object {

    @objc dynamic var name = ""
    @objc dynamic var email = ""
    @objc dynamic var password = ""
    
//    init(name: String, email: String, password: String) {
//        self.name = name
//        self.email = email
//        self.password = password
//    }
    //
//    required init() {
//        fatalError("init() has not been implemented")
//    }
//
//    required init(realm: RLMRealm, schema: RLMObjectSchema) {
//        fatalError("init(realm:schema:) has not been implemented")
//    }
}

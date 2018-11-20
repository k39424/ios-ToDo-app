//
//  Joke.swift
//  todo-app
//
//  Created by Michael Florendo on 19/11/2018.
//  Copyright © 2018 Michael Florendo. All rights reserved.
//

import Foundation
import ObjectMapper

struct Joke: Mappable {
    var value: String?
    
    init(value: String) {
        self.value = value
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        value <- map["value"] 
    }
}

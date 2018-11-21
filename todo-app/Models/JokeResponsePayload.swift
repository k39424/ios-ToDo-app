//
//  JokeResponsePayload.swift
//  todo-app
//
//  Created by Michael Florendo on 21/11/2018.
//  Copyright © 2018 Michael Florendo. All rights reserved.
//

import Foundation
import ObjectMapper

struct JokeResponsePayload: Mappable {
    var result: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        result <- map["result"]
    }
}

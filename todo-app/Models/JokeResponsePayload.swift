//
//  JokeResponsePayload.swift
//  todo-app
//
//  Created by Michael Florendo on 21/11/2018.
//  Copyright © 2018 Michael Florendo. All rights reserved.
//

import Foundation
import ObjectMapper

class JokeResponsePayload: Mappable {
    var result: Array<[String:Any]>?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        result <- map["result"]
        
    }
}

//
//  Joke.swift
//  todo-app
//
//  Created by Michael Florendo on 19/11/2018.
//  Copyright © 2018 Michael Florendo. All rights reserved.
//

import Foundation
import ObjectMapper
import IGListKit

class Joke: Mappable {
    var value: String?
    
    init(value: String) {
        self.value = value
    }
    
    required init?(map: Map) {
        
    }
    
     func mapping(map: Map) {
        value <- map["value"]
    }
}

extension Joke: Equatable {
    static func == (lhs: Joke, rhs: Joke) -> Bool {
        return rhs.value == lhs.value
    }
    
    
}

extension Joke: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return NSString(string: value ?? "")
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? Joke else {
            return false
        }
        
        if value != object.value {
            return false
        }
        
        return self == object
    }
}

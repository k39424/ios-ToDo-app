//
//  ChuckNorrisJokes.swift
//  todo-app
//
//  Created by Michael Florendo on 19/11/2018.
//  Copyright © 2018 Michael Florendo. All rights reserved.
//

import Foundation
import Moya
import Alamofire

enum ChuckNorrisJokes {
    case view(query: String)
}

extension ChuckNorrisJokes : TargetType {
    var baseURL: URL {
        return URL(string: "https://api.chucknorris.io")!
    }
    
    var path: String {
        switch self {
        case.view(let query):
            return "/jokes/search?query=\(query)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .view(let query):
            return .requestParameters(parameters: [query: query], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}

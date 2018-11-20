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
        case.view:
            return "/jokes/search"
        }
    }
    
    var method: Moya.Method {
//        switch self {
//        case .view(let query):
            return .get
            
//        default:
//            return .get
//        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .view(let query):
            return .requestParameters(parameters: ["query": query], encoding: URLEncoding.queryString)
//            return .requestParameters(parameters: ["query": query], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
//        return ["Content-Type": "application/json"]
        return ["Content-Type": "application/json; charset=utf-8"]
    }
}

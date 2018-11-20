//
//  JokesDelegate.swift
//  todo-app
//
//  Created by Michael Florendo on 19/11/2018.
//  Copyright © 2018 Michael Florendo. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import ObjectMapper

protocol JokesDelegate{
    func operationResult(message: String)
}

class JokesPresenter {
    let jokesProvider = MoyaProvider<ChuckNorrisJokes>()
    var delegate : JokesDelegate
    
    init(delegate: JokesDelegate) {
        self.delegate = delegate
    }
    
    func getJokes(query: String) {
        jokesProvider.request(.view(query: "test")) { result in
            switch result {
                case .success:
                    do {
//                        try print(result.value?.data)
                        var jsonResponse = try result.value?.mapJSON()
                        
                        print("Response: \(String(describing: jsonResponse))")
//                        let test = Joke(JSONString: jsonResponse)
//                        let test = Mapper<Joke>().map(JSONString: String(describing:jsonResponse))
                        let jsonArray = Mapper<Joke>().mapArray(JSONString: String(describing: jsonResponse))
//                        print("JSONArray Count: \(jsonArray?.count)")
//                        for jsonObject in jsonArray! {
//                            print("Object: \(jsonObject.value)")
//                        }
//                        print("JOKE: \(test?.value)")
//                        let test = Joke?(JSONString: String(describing:jsonResponse))
//                        let joke = Mapper<Joke>().map(JSONString: String(describing: jsonResponse))
                        
//                        print("JOKE: \(String(describing: joke?.value))")
//                        let joke = Mapper<Joke>().map(JSONString: jsonResponse)
                        /*
                         let person = Mapper<Person>().map(JSONString: JSONString)
                         // It also supports object to json
                         let JSONString = Mapper().toJSONString(person, prettyPrint: true) */
                    } catch {
                        print("Failed to Parse Response: \(error)")
                    }
                
                case .failure:
                    print("Failure")
            }
        }
    }
}

extension JokesPresenter: JokesDelegate {
    func operationResult(message: String) {
        print(message)
    }
    
    func makeRequest() {
        Alamofire.request("https://api.chucknorris.io/jokes/search?query=test").responseJSON { response in
            print("Response: \(response.response)")
            print("Response Status: \(response.response?.value(forKey: "total"))")
        }
    }
}

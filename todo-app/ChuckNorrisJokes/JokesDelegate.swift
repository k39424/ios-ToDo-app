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
//                        self.state = .ready(try response.map(MarvelResponse<Comic>.self).data.results)
//                        guard let jsonResponse = try result.value?.mapJSON() else {
//                            print("Failed to parse jsonResponse")
//                            return
//                        }
                         let jsonResponse = try result.value?.mapJSON()
//                        let jsonResult = Mapper<JokeResponsePayload>().map(JSONObject: jsonResponse)
//                        print(jsonResult?.result)
                        print(String(describing: jsonResponse))
                        let jsonResult = try Mapper<JokeResponsePayload>().map(JSONObject: jsonResponse)
                        
                        
                        
                        
//                        let jsonPayload = Mapper<JokeResponsePayload>().map(JSONObject: jsonResponse)
//                        let jsonResult = Mapper<JokeResponsePayload>().map(JSONObject: jsonResponse)
//                        print(jsonResult?.result)
//                        let jsonJokeList = Mapper<Joke>().map(JSONObject: jsonPayload)
//                        let jsonJokeList = Mapper<Joke>().map
//                        print(jsonJokeList?.value)
                        
//                        let jsonResponse = try result.value?.mapJSON()
                        
//                        guard let responseJSON = result.value as? [String: AnyObject] else {
//                            failure(0,"Error reading response")
//                            return
//                        }
                        
//                        guard let jsonResponse = try result.value?.mapJSON() as? [String: AnyObject] else {
//                            self.delegate.operationResult(message: "Failed to Parse")
//                            return
//                        }
                        
//                        guard let test = try result.value?.mapJSON() as? [String: AnyObject] else {
//                            print("Failed to Parse Test")
//                            return
//                        }
//
//                        print(test.values)
//                        let testJokes = Mapper<Joke>().map(JSONObject: test)
                       
//                        let testJokes2 = Mapper<Joke>().mapArray(JSONObject: testJokes)
//                        let testJokes2 = Mapper<Joke>().map(JSONObject: test)
                        
//                        let customer = Mapper<Customer>().map(JSONObject: responseJSON)

//                        print(testJokes?.value)
//                        print(testJokes)
//                        for joke in testJokes {
//                            print(joke.)
//                        }
                        
//                        guard let jsonObj = try result.value?.mapJSON() as? Array<[String: AnyObject]> else {
//
//                            print("failed to parse jsonObj")
//                            return
//                        }
                        
                        
//                        let jsonResult = Mapper
                        
                        
//                        guard let jokes = Mapper<Joke>().mapArray(JSONObject: test) else {
//                            print("Failed to Make Jokes")
//                            return
//                        }
                        
//                        let jsonResult = Mapper<Joke>().map(JSON: jsonResponse)
//                        print("jsonResult: \(jsonResult?.value)")
                        
//                        let customer = Mapper<Customer>().map(JSONObject: responseJSON)
//                        print("JSONRESPONSE: \(jsonResponse.values)")
                        
//                      let jsonArray = Mapper<Joke>().mapArray(JSONObject: jsonResponse)
                        
//                        let jsonArray = Mapper<Joke>().mapArray(JSONString: String(describing: jsonResult))

//                        guard let responseJSON = jsonResponse.values as? Array<[String: AnyObject]> else {
//                            print("Failed to parse array")
//                            return
//                        }
//                        guard let customers:[Customer] = Mapper<Customer>().mapArray(JSONArray: responseJSON) else {
//                            failure(0,"Error mapping response")
//                            return
//                        }
                        
//                        guard let jokes = Mapper<Joke>().mapArray(JSONObject: jsonResponse) else {
//                            print("Failed to Make Jokes")
//                            return
//                        }
                        
//                        guard let jokes = Mapper<Joke>().mapArray(JSONArray: jsonResponse) else {
//                            print("Failed to Make Jokes")
//                            return
//                        }
//
//                        print("JSONArray Count: \(jsonResponse.count)")
//                        for jsonObject in jsonResponse {
//                            print("Object: \(jsonObject.value)")
//                        }
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

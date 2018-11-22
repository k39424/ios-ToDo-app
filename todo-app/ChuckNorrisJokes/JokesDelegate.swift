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
    func operationResult(jokeList: Array<Joke>, message: String)
}

class JokesPresenter {
    let jokesProvider = MoyaProvider<ChuckNorrisJokes>()
    var delegate : JokesDelegate
    var jokesList : Array<Joke> = []
    
    init(delegate: JokesDelegate) {
        self.delegate = delegate
    }
    
    func getJokes(query: String) {
        
        self.jokesProvider.request(.view(query: "test")) { result in
            switch result {
                case .success:
                    do {
                        guard let json = try result.value?.mapJSON() else {
                            self.delegate.operationResult(jokeList: self.jokesList, message: "Failed to get Jokes")
                            return
                        }
                        
                        guard let jsonResult = Mapper<JokeResponsePayload>().map(JSONObject: json)
                            else {
                                self.delegate.operationResult(jokeList: self.jokesList, message: "Failed to get Jokes")
                                return
                        }
                        
                       
                        guard let jokes = Mapper<Joke>().mapArray(JSONObject: jsonResult.result) else {
                            self.delegate.operationResult(jokeList: self.jokesList, message: "Failed to get Jokes")
                            return
                        }
                        
                        for test in jokes {
                            print(test.value ?? "We dont have jokes")
                        }
                    
                        self.jokesList = jokes
                        
                        self.delegate.operationResult(jokeList: self.jokesList, message: "Succcess getting jokes")
                        
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
    func operationResult(jokeList: Array<Joke>, message: String) {
        print(message)
    }
    
    func makeRequest() {
        Alamofire.request("https://api.chucknorris.io/jokes/search?query=test").responseJSON { response in
            print("Response: \(response.response)")
            print("Response Status: \(response.response?.value(forKey: "total"))")
        }
    }
}

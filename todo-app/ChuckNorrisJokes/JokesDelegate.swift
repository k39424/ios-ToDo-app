//
//  JokesDelegate.swift
//  todo-app
//
//  Created by Michael Florendo on 19/11/2018.
//  Copyright © 2018 Michael Florendo. All rights reserved.
//

import Foundation
import Moya

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
                        try print("Success \(result.value)")
//                        try print("Success \(String(describing: result.value?.mapJSON()))")
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
}

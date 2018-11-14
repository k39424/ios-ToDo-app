//
//  DBManager.swift
//  todo-app
//
//  Created by Michael Florendo on 13/11/2018.
//  Copyright © 2018 Michael Florendo. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class DBManager {
    private var realm: Realm
    static let sharedInstance = DBManager()
    
    init() {
        realm = try! Realm()
    }
    //get all users
    func getUsers() -> Results<RealmUser> {
        let results: Results<RealmUser> = realm.objects(RealmUser.self)
        return results
    }
    //add user
    func addUser(user: RealmUser)->Bool {
        do {
            try self.realm.write {
                realm.add(user)
            }
            
        } catch {
            print("\(user.name) was not added")
            return false
        }
        
        print("\(user.name) was added")
        return true
    }
    //delete user
    func deleteUser(user: RealmUser)-> Bool {
        do {
            try self.realm.write {
                realm.delete(user)
            }
        } catch {
            print("\(user.name) was deleted")
            return false
        }
        
        print("\(user.name) was added")
        return true
    }
    
//    func getDataFromDB() ->Results (
//    let results: Results<Route> =   database.objects(Item.self)
//    return results
//    let results: Result
//    )
}

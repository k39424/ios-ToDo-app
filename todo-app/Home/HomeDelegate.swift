//
//  HomeDelegate.swift
//  todo-app
//
//  Created by Michael Florendo on 15/11/2018.
//  Copyright © 2018 Michael Florendo. All rights reserved.
//

import Foundation
import RealmSwift

protocol HomeDelegate {
    func operationResult(message: String)
}

class HomePresenter {
    var delegate: HomeDelegate
    var realm: Realm
    
    init(delegate: HomeDelegate) {
        self.delegate = delegate
        self.realm = try! Realm()
    }
    
    func AddTodo(task: String)-> Bool {
        //validate
        if task.isEmpty {
            self.delegate.operationResult(message: "Task can't be empty")
            return false
        }
        //create RealmTodo object
        let todo = RealmTodo()
        todo.task = task
        todo.status = false
        
        //add to realm then return operation result
        return realmAddTodo(todo: todo)
    }
    
}

//Realm implementation - just want to separate these
extension HomePresenter {
    func realmAddTodo(todo: RealmTodo)->Bool {
        do {
            try realm.write {
                realm.add(todo)
                self.delegate.operationResult(message: "Todo was successfully added")
            }
        } catch {
            self.delegate.operationResult(message: "Failed Adding Todo to Realm")
            return false
        }
        
        return true
    }
    
    func realmEditTodo(todo: RealmTodo)->Bool {
        return true
    }
    
    func realmDeleteTodo(todo: RealmTodo)->Bool {
        do {
            try self.realm.write {
                realm.delete(todo)
            }
        } catch {
            return false
        }
        return true
    }
    
    func realmGetTodos()->Results<RealmTodo> {
        let todoList : Results<RealmTodo> = realm.objects(RealmTodo.self)
        return todoList
    }
}

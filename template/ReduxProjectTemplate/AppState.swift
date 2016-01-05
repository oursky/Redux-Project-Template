//
//  AppState.swift
//  ReduxProjectTemplate
//
//  Created by Steven Chan on 5/1/16.
//  Copyright © 2016 oursky. All rights reserved.
//

import Redux

struct AppState: ReduxAppState, AnyEquatable, Equatable {
    
    func get(key: String) -> AnyEquatable? {
        /*

            switch key {
            case "Todo": return self.todoList
            default: return nil
            }

        */
        return nil
    }
    
    mutating func set(key: String, value: AnyEquatable) {
        /*

            switch key {
            case "Todo":
                self.todoList = value as! TodoListState
                break
            default:
                break
            }

        */
    }
}

func ==(lhs: AppState, rhs: AppState) -> Bool {
    return true
}


extension ReduxStore {
    
    /*

    func getTodoListState() -> TodoListState {
        return getAppState().get("Todo") as! TodoListState
    }

    */
    
}

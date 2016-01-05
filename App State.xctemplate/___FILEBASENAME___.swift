//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

import Redux

struct ___FILEBASENAMEASIDENTIFIER___: ReduxAppState, AnyEquatable, Equatable {
    
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

func ==(lhs: ___FILEBASENAMEASIDENTIFIER___, rhs: ___FILEBASENAMEASIDENTIFIER___) -> Bool {
    return true
}


extension ReduxStore {
    
    /*

    func getTodoListState() -> TodoListState {
        return getAppState().get("Todo") as! TodoListState
    }

    */
    
}

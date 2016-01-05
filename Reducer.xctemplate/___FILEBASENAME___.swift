//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

import Redux

struct ___VARIABLE_StateClass___: AnyEquatable, Equatable {
    
}

func ==(lhs: ___VARIABLE_StateClass___, rhs: ___VARIABLE_StateClass___) -> Bool {
    // compare members of the two states
    return true
}

func ___VARIABLE_ReducerName___(previousState: Any, action: ReduxAction) -> Any {
    var state = previousState as! ___VARIABLE_StateClass___
    
    /*

    Implement logic here
    
    e.g.
    
        switch action.payload {
        case .Increment(let amount):
            state.value += amount
            break
        
        default:
            break
        }
    
    */
    
    return state
}
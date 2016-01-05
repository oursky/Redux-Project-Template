//
//  ReplaceMeReducer.swift
//  ReduxProjectTemplate
//
//  Created by Steven Chan on 5/1/16.
//  Copyright © 2016 oursky. All rights reserved.
//

import Redux

struct ReplaceMeState: AnyEquatable, Equatable {
    
}

func ==(lhs: ReplaceMeState, rhs: ReplaceMeState) -> Bool {
    // compare members of the two states
    return true
}

func replaceMeReducer(previousState: Any, action: ReduxAction) -> Any {
    var state = previousState as! ReplaceMeState
    
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
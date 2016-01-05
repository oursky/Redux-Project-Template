//
//  ReplaceMeReducerTests.swift
//  ReduxProjectTemplate
//
//  Created by Steven Chan on 5/1/16.
//  Copyright © 2016 oursky. All rights reserved.
//

import XCTest
@testable import ReduxProjectTemplate

class ReplaceMeReducerTests: XCTestCase {

    var initialState: ReplaceMeState?
    
    override func setUp() {
        super.setUp()

        initialState = ReplaceMeState()
    }
    
    override func tearDown() {
        super.tearDown()

        initialState = nil
    }
    
    func testExample() {
        var nextState: Any = initialState!
        nextState = replaceMeReducer(
            nextState,
            action: ReduxAction(payload: ReplaceMeAction.ReplaceMe)
        )
        XCTAssert(nextState != initialState)
        // XCTAssert(nextState.count == 1)
    }

}

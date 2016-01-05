//
//  ReplaceMeActionTests.swift
//  ReduxProjectTemplate
//
//  Created by Steven Chan on 5/1/16.
//  Copyright © 2016 oursky. All rights reserved.
//

import XCTest
@testable import ReduxProjectTemplate

class ReplaceMeActionTests: XCTestCase {

    let mockUserDefaults: NSUserDefaults = NSUserDefaults(suiteName: "ReplaceMeActionTests")!
    let mockDispatch: MockDispatch = createMockDispatch()

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        let dict = mockUserDefaults.dictionaryRepresentation()
        for (k, _) in dict {
            mockUserDefaults.removeObjectForKey(k)
        }
        mockDispatch.cleanup()
    }
    
    func testExample() {
        // test
    }

}

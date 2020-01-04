//
//  FeedsModelTest.swift
//  WiproAssignmentTests
//
//  Created by Apple on 04/01/20.
//  Copyright © 2020 Nitin Singh Rathore. All rights reserved.
//

import XCTest
@testable import WiproAssignment

class FeedsModelTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let feedModel = try? JSONDecoder().decode(FeedsModel.self, from: Data())
        if feedModel == nil {
            XCTAssert(false, "Expected failure when no data")
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

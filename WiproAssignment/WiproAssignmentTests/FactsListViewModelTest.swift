//
//  FactsListViewModelTest.swift
//  WiproAssignmentTests
//
//  Created by Apple on 22/12/19.
//  Copyright © 2019 Nitin Singh Rathore. All rights reserved.
//

import XCTest
@testable import WiproAssignment

class FactsListViewModelTest: XCTestCase {

    var viewModel: FactsListViewModel!

    
    override func setUp() {
        super.setUp()
        self.viewModel = FactsListViewModel()
    }

    override func tearDown() {
        super.tearDown()
        self.viewModel = nil
    }

    func testFetchFeeds() {
        
        self.viewModel.contactDidChanges = { (finished, error) in
            if error {
                XCTAssert(false, "Fetching facts from server fail")
            } else {
                XCTAssert(true, "Fetching facts from server pass")

            }
        }
        self.viewModel.fetchFactsList()
        
    }

}

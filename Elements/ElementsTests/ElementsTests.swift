//
//  ElementsTests.swift
//  ElementsTests
//
//  Created by casandra grullon on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import XCTest
@testable import Elements
class ElementsTests: XCTestCase {


    func testGetElements() {
        let exp = XCTestExpectation(description: "elements found")
        
        ElementsAPIClient.getElements { (result) in
            switch result {
            case .failure(let appError):
                XCTFail("app error: \(appError)")
            case .success:
                exp.fulfill()
                XCTAssertNotNil(true, "array of elements not empty")
            }
        }
        wait(for: [exp], timeout: 5.0)
    }

}

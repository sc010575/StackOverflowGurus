//
//  StackOverflowGurusTests.swift
//  StackOverflowGurusTests
//
//  Created by Suman Chatterjee on 07/10/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import XCTest
@testable import StackOverflowGurus

class ModelStoreTests: XCTestCase {

    func test_GivenAModelResponse_WhenResponseHaveRightData_ThenAModelWillbeCreated() {

        guard let modelToTestData = Fixture.getData("users") else { return XCTAssert(true, "json file error") }

        let modelResult: Result<ModelStore?, AppError> = Serialize.parse(data: modelToTestData)

        switch modelResult {
        case .success(let modelToTest):
            XCTAssertEqual(modelToTest?.items.count, 3)
            XCTAssertEqual(modelToTest?.items.first?.displayName, "Jon Skeet")
            XCTAssertEqual(modelToTest?.items.first?.profileImage, "Jon/Url")
            XCTAssertEqual(modelToTest?.items.first?.reputation, 100)
        default:
            break
        }
    }

    func test_GivenAModelResponse_WhenResponseHaveEmptyData_ThenAModelStillWillbeCreated() {

        guard let modelToTestData = Fixture.getData("users") else { return XCTAssert(true, "json file error") }

        let modelResult: Result<ModelStore?, AppError> = Serialize.parse(data: modelToTestData)

        switch modelResult {
        case .success(let modelToTest):
            XCTAssertEqual(modelToTest?.items[1].displayName, "")
        default:
            break
        }
    }
}


//
//  HomeViewModelTest.swift
//  StackOverflowGurusTests
//
//  Created by Suman Chatterjee on 07/10/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import XCTest
@testable import StackOverflowGurus

class HomeViewModelTest: XCTestCase {

    let network = NetworkMock()
    var viewModel:HomeViewModelUseCase?
    var stackOverflowService: StackOverflowServiceUseCase?
    override func setUp() {
        let stackOverflowService = StackOverflowService(network)
        viewModel = HomeViewModel(service:stackOverflowService)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_GivenAHomeViewModel_WhenViewModelHaveAValidService_ThenViewModelShouldGenerateSortedCellModel() {
        
        let extectation = expectation(description: "fatch jobs")
        viewModel?.fetchUsers(completion: { (resultSuccess) in
            extectation.fulfill()
            switch resultSuccess {
            case .success(let testCellViewModels):
                XCTAssertEqual(testCellViewModels.count, 3)
                let testCellViewModel = testCellViewModels[0]
                XCTAssertEqual("A Name",testCellViewModel.name)
                XCTAssertEqual(testCellViewModel.prifileImage, "Profile/Url")
                XCTAssertEqual(testCellViewModel.reputation, 300)
            default:
                break
            }
        })
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_GivenAHomeViewModel_WhenViewModelHaveEmptyName_ThenShouldHaveUnknownName() {
        
        let extectation = expectation(description: "fatch jobs")
        viewModel?.fetchUsers(completion: { (resultSuccess) in
            extectation.fulfill()
            switch resultSuccess {
            case .success(let testCellViewModels):
                XCTAssertEqual(testCellViewModels.count, 3)
                let testCellViewModel = testCellViewModels[1]
                XCTAssertEqual("Unknown User",testCellViewModel.name)
            default:
                break
            }
        })
        self.waitForExpectations(timeout: 1, handler: nil)
    }
}


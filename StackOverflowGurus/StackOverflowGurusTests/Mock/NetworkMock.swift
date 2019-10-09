//
//  NetworkMock.swift
//  StackOverflowGurusTests
//
//  Created by Suman Chatterjee on 07/10/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation
@testable import StackOverflowGurus

class NetworkMock: NetworkUseCase {
    func send(url: String, completion: @escaping (ResultType) -> Void) {
        guard let modelToTestData = Fixture.getData("users") else { return }
        completion(.success(modelToTestData))
    }
}


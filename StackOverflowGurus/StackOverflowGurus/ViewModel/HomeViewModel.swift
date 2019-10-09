//
//  HomeViewModel.swift
//  StackOverflowGurus
//
//  Created by Suman Chatterjee on 07/10/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import UIKit


protocol HomeViewModelUseCase {
    typealias ResultType = Result<[CellViewModel], AppError>
    func fetchUsers(completion: @escaping(ResultType) -> Void)

}

class HomeViewModel: HomeViewModelUseCase {
    private let service : StackOverflowServiceUseCase

    init(service:StackOverflowServiceUseCase = StackOverflowService()) {
        self.service = service
    }
    
    func fetchUsers(completion: @escaping(ResultType) -> Void) {
        service.sendModel { (results) in
            switch results {
            case .success(let models):
                let items = models.items
                let cellViewModels = items.map { CellViewModel($0) }.sorted (by:{ $0.reputation > $1.reputation
                })
                completion(.success(cellViewModels))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

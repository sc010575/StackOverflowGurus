//
//  Network.swift
//  StackOverflowGurus
//
//  Created by Suman Chatterjee on 07/10/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation

enum AppConstant {
    static let BaseUrl = "https://api.stackexchange.com/2.2/users?pagesize=20&order=desc&sort=reputation&site=stackoverflow"
}

protocol NetworkUseCase {
    typealias ResultType = Result<Data, AppError>
    func send(url: String, completion: @escaping (ResultType) -> Void)
}

final class Network: NetworkUseCase {
    func send(url: String, completion: @escaping (ResultType) -> Void) {

        guard let baseUrl = URL(string: url) else { return completion(.failure(.dataError(message: "Url is not correct")))

        }

        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let task = session.dataTask(with: baseUrl) { (data, response, error) in
            var result: ResultType
            if let error = error {
                result = .failure(.networkError(message: error.localizedDescription))
            } else {

                if let httpResponse = response as? HTTPURLResponse, let data = data,
                    httpResponse.statusCode == 200 {
                    result = .success(data)
                } else {
                    result = .failure(.dataError(message: "Data/Server error"))
                }
            }
            DispatchQueue.main.async {
                completion(result)
            }

        }
        task.resume()
    }
}



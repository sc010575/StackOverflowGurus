//
//  Fixture.swift
//  StackOverflowGurusTests
//
//  Created by Suman Chatterjee on 07/10/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation

final class Fixture  {
    
    static func getData(_ fileName:String, type:String = "json") -> Data? {
        guard let path = Bundle(for: Fixture.self).path(forResource: fileName, ofType: type),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path))
            else {
                return nil
        }
        return data
    }
}

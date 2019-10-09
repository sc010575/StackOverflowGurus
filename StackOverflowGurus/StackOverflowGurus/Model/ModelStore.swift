//
//  ModelStore.swift
//  StackOverflowGurus
//
//  Created by Suman Chatterjee on 07/10/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation

struct ModelStore: Decodable {
    let items: [User]
}

struct User : Decodable {
    var displayName: String?
    let profileImage: String?
    let reputation: Int?
}

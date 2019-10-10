//
//  CellViewModel.swift
//  StackOverflowGurus
//
//  Created by Suman Chatterjee on 07/10/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation

struct CellViewModel {
    var name: String
    var prifileImage: String?
    var reputation: Int
    var isExpanded: Bool
    var isFollow: Bool
    var isBlocked: Bool

    init(_ user: User) {
        self.name = user.displayName?.count == 0 ? "Unknown User" : user.displayName ?? "Unknown User"
        self.prifileImage = user.profileImage
        self.reputation = user.reputation ?? 0
        self.isExpanded = false
        self.isFollow = false
        self.isBlocked = false
    }
}

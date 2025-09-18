//
//  Bool+Comparable.swift
//  FriendFace
//
//  Created by Georgi Ignatov on 15.07.25.
//

import Foundation

extension Bool: @retroactive Comparable {
    public static func <(lhs: Self, rhs: Self) -> Bool {
        !lhs && rhs
    }
}

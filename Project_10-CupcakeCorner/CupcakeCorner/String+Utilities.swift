//
//  String+Utilities.swift
//  CupcakeCorner
//
//  Created by Georgi Ignatov on 3.07.25.
//

import Foundation

extension String {
    var isEmptyString: Bool {
        self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}

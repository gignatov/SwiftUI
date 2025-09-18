//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Georgi Ignatov on 7.04.25.
//

import SwiftUI

struct FlagImage: View {
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

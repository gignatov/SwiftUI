//
//  Image+DataInit.swift
//  PhotoMemoir
//
//  Created by Georgi Ignatov on 24.07.25.
//

import SwiftUI

extension Image {
    init(imageData: Data) {
        guard let uiImage = UIImage(data: imageData) else {
            self.init(systemName: "photo.trianglebadge.exclamationmark")
            return
        }
            
        self.init(uiImage: uiImage)
    }
}

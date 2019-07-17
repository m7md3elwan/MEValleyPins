//
//  MEValley+Image.swift
//  MEValleyPins
//
//  Created by Mohamed Mostafa on 7/16/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import Foundation
import UIKit

enum ImageAsset: String {
    case like = "like"
    case unlike = "unlike"
    case imagePlaceholder = "image-placeholder"
    case profilePlaceholder = "user-placeholder"
    case errorImage = "errorImage"
}

extension UIImage {
    convenience init?(asset image: ImageAsset) {
        self.init(named: image.rawValue)
    }
}

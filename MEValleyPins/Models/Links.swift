//
//  Links.swift
//  MEValleyPins
//
//  Created by Mohamed Mostafa on 7/16/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import Foundation

class Links: Codable {
    let `self`: String?
    let html: String?
    let download: String?
    let photos: String?
    let likes: String?
    
    enum CodingKeys: String, CodingKey {
        case `self` = "self"
        case html
        case download
        case photos
        case likes
    }
}

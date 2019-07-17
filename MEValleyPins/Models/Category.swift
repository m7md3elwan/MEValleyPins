//
//  Category.swift
//  MEValleyPins
//
//  Created by Mohamed Mostafa on 7/16/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import Foundation

class Category: Codable {
    let id: Int?
    let title: String?
    let photoCount: Int?
    let links: ImageUrls?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case photoCount = "photo_count"
        case links
    }
}

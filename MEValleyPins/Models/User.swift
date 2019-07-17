//
//  User.swift
//  MEValleyPins
//
//  Created by Mohamed Mostafa on 7/16/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import Foundation

class User: Codable {
    let id: String?
    let userName: String?
    let name: String?
    let profileImage: ImageUrls?
    let links : Links?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userName
        case name
        case profileImage = "profile_image"
        case links
    }
}

//
//  MECachable.swift
//  MEValleyLoader
//
//  Created by Mohamed Mostafa on 7/13/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import Foundation

protocol MECachable {
    var cacheLimit: Int { get set }
    func clearCache()
    func getData(key: NSString) -> Any?
    func set(data: Any?, key: NSString)
}



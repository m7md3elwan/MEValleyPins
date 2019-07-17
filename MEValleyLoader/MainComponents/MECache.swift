//
//  MECache.swift
//  MEValleyLoader
//
//  Created by Mohamed Mostafa on 7/13/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import Foundation
import UIKit

open class MECache: NSObject, MECachable {
    
    // MARK:- Properties
    private var cache = NSCache<NSString, MEDiscardableData>()
    var cacheLimit: Int = 100 {
        didSet {
            setCacheMaxLimit(cacheLimit: cacheLimit)
        }
    }
    
    // MARK:- Init
    override init() {
        super.init()
        cache.delegate = self
        setCacheMaxLimit(cacheLimit: cacheLimit)
    }
    
    // MARK:- Methods
    // MARK: Private methods
    fileprivate func setCacheMaxLimit(cacheLimit: Int) {
        cache.countLimit = cacheLimit
    }
    
    
    // MARK: Public methods
    func getData(key: NSString) -> Any? {
        if let cachedObject = cache.object(forKey: key) {
            return cachedObject.data
        }
        return nil
    }
    
    func set(data: Any?, key: NSString) {
        if data == nil {
            cache.removeObject(forKey: key)
            return
        }
        let data = MEDiscardableData(data: data)
        cache.setObject(data, forKey: key)
    }
    
    func clearCache() {
        cache.removeAllObjects()
    }
}

extension MECache: NSCacheDelegate {
    public func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: Any) {
        
    }
}



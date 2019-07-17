//
//  MECacheTests.swift
//  MEValleyLoaderTests
//
//  Created by Mohamed Mostafa on 7/13/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import XCTest
import Quick
import Nimble

@testable import MEValleyLoader

class MECacheTests: QuickSpec {
    override func spec() {
        
        var cache: MECachable = MECache()
        
        let image1 = UIImage(named: "1", in: Bundle(for:MECacheTests.self), compatibleWith: nil)
        let image2 = UIImage(named: "2", in: Bundle(for:MECacheTests.self), compatibleWith: nil)
        let image3 = UIImage(named: "3", in: Bundle(for:MECacheTests.self), compatibleWith: nil)
        let image4 = UIImage(named: "4", in: Bundle(for:MECacheTests.self), compatibleWith: nil)
        let image5 = UIImage(named: "5", in: Bundle(for:MECacheTests.self), compatibleWith: nil)
        
        
        describe("testing cache") {
            
            context("Setting cache limit more than cached data") {
                beforeEach {
                    cache.clearCache()
                    cache.cacheLimit = 10
                    
                    cache.set(data: image1!, key: "1")
                    cache.set(data: image2!, key: "2")
                    cache.set(data: image3?.jpegData(compressionQuality: 0)!, key: "3")
                    cache.set(data: image4?.jpegData(compressionQuality: 0)!, key: "4")
                    cache.set(data: image5?.jpegData(compressionQuality: 0)!, key: "5")
                }
                
                
                it("Stored data successfuly") {
                    expect(cache.getData(key: "1")).toNot(beNil())
                    expect(cache.getData(key: "2")).toNot(beNil())
                    expect(cache.getData(key: "3")).toNot(beNil())
                    expect(cache.getData(key: "4")).toNot(beNil())
                    expect(cache.getData(key: "5")).toNot(beNil())
                }
            }
            
            context("Setting cache limit less than cached data") {
                beforeEach {
                    cache.clearCache()
                    cache.cacheLimit = 3
                }
                
                it("Clears first 2 added data") {
                    cache.set(data: image1?.jpegData(compressionQuality: 0)!, key: "1")
                    cache.set(data: image2?.jpegData(compressionQuality: 0)!, key: "2")
                    cache.set(data: image3?.jpegData(compressionQuality: 0)!, key: "3")
                    cache.set(data: image4?.jpegData(compressionQuality: 0)!, key: "4")
                    cache.set(data: image5?.jpegData(compressionQuality: 0)!, key: "5")
                    
                    expect(cache.getData(key: "1")).to(beNil())
                    expect(cache.getData(key: "2")).to(beNil())
                    expect(cache.getData(key: "3")).toNot(beNil())
                    expect(cache.getData(key: "4")).toNot(beNil())
                    expect(cache.getData(key: "5")).toNot(beNil())
                }
                
                context("accessing key 1 more than 1 time") {
                    beforeEach {
                        cache.clearCache()
                        cache.cacheLimit = 3
                        
                        cache.set(data: image1?.jpegData(compressionQuality: 0)!, key: "1")
                        _ = cache.getData(key: "1")
                        _ = cache.getData(key: "1")
                        _ = cache.getData(key: "1")
                        cache.set(data: image2?.jpegData(compressionQuality: 0)!, key: "2")
                        cache.set(data: image3?.jpegData(compressionQuality: 0)!, key: "3")
                        cache.set(data: image4?.jpegData(compressionQuality: 0)!, key: "4")
                        cache.set(data: image5?.jpegData(compressionQuality: 0)!, key: "5")
                    }
                    
                    it("Clears key 3 instead of 1") {
                        expect(cache.getData(key: "1")).toNot(beNil()) // Data of key 1 wasn't released
                        expect(cache.getData(key: "2")).to(beNil())
                        expect(cache.getData(key: "3")).to(beNil())
                        expect(cache.getData(key: "4")).toNot(beNil())
                        expect(cache.getData(key: "5")).toNot(beNil())
                    }
                }
            }
        }
    }
}

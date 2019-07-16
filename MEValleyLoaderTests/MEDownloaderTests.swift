//
//  MEDownloaderTests.swift
//  MEValleyLoaderTests
//
//  Created by Mohamed Mostafa on 7/15/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import MEValleyLoader

class MEDownloaderTests: QuickSpec {
    override func spec() {
        
        var loader: MEDownloader!
        var request1: MEDownloadRequest!
        var request2: MEDownloadRequest!
        var request3: MEDownloadRequest!
        
        // Test data
        let image1 = UIImage(named: "1", in: Bundle(for:MECacheTests.self), compatibleWith: nil)
        let testData = image1!.pngData()!
        
        describe("testing Loader") {
            
            beforeEach {
                loader = MEDownloader()
                request1 = loader.downloadWithURL(url: URL(string: "http:images.com")!)
                request2 = loader.downloadWithURL(url: URL(string: "http:images.com")!)
                request3 = loader.downloadWithURL(url: URL(string: "http:images1.com")!)
            }
            
            context("adding and remove of tasks") {
                it("combine same url in same task") {
                    expect(loader.downloadTasks.count).to(equal(2))
                }
                
                it("removes canceled request") {
                    request3.cancel()
                    expect(loader.downloadTasks.count).to(equal(1))
                }
            }
            
            context("Download and Error") {
                it("download request successfully") {
                    
                    request1.onSuccess({ (data) in
                        expect(data).to(equal(testData))
                    }).onFail({ (error) in
                        fail()
                    })
                    
                    loader.urlSession(loader.session, dataTask: request1.task!.downloadTask!, didReceive: testData)
                    loader.urlSession(loader.session, task: request1.task!.downloadTask!, didCompleteWithError: nil)
                }
                
                it("return request errors successfully") {
                    
                    request1.onFail({ (error) in
                        expect(error).toNot(beNil())
                    })
                    
                    loader.urlSession(loader.session, task: request1.task!.downloadTask!, didCompleteWithError: NSError(domain: "error", code: 1, userInfo: nil))
                }
            }
            
            
            context("notifying all request sharing same link") {
                
                it("download request successfully") {
                    
                    request1.onSuccess({ (data) in
                        expect(data).to(equal(testData))
                    }).onFail({ (error) in
                        fail()
                    })
                    
                    request2.onSuccess({ (data) in
                        expect(data).to(equal(testData))
                    }).onFail({ (error) in
                        fail()
                    })
                    
                    loader.urlSession(loader.session, dataTask: request1.task!.downloadTask!, didReceive: testData)
                    loader.urlSession(loader.session, task: request1.task!.downloadTask!, didCompleteWithError: nil)
                }
            }

            afterEach {
                loader = nil
            }
        }
    }
}

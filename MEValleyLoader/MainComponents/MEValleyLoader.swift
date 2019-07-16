//
//  MEValleyLoader.swift
//  MEValleyLoader
//
//  Created by Mohamed Mostafa on 7/15/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import Foundation

open class MEValleyLoader {
    
    // MARK:- Properties
    var cache: MECachable
    var dataLoader: MEDownloadable
    
    // MARK:- Init
    init(cache: MECachable = MECache(), dataLoader: MEDownloadable = MEDownloader()) {
        self.cache = cache
        self.dataLoader = dataLoader
    }
    
    // MARK:- Methods
    // MARK: Public methods
    func getData(with url: URL, completion: @escaping (Data?) -> Void) {
        let key = url.absoluteString
        
        if let data = cache.getData(key: key as NSString) as? Data {
            completion(data)
        } else {
            dataLoader.downloadWithURL(url: url)
                .onSuccess { (data) in
                    completion(data)
                }.onFail { (error) in
                    completion(nil)
            }
        }
    }
}

protocol ImageFetcherable {
    func getImage(with url: URL, completion: @escaping (UIImage?) -> Void)
}

extension MEValleyLoader: ImageFetcherable {
    func getImage(with url: URL, completion: @escaping (UIImage?) -> Void) {
        getData(with: url) { (data) in
            if let data = data {
                completion(UIImage(data: data))
            } else {
                completion(nil)
            }
        }
    }
    
    func getObject<T: Codable>(with url: URL, completion: @escaping (T?) -> Void) {
        
        getData(with: url) { (data) in
            if let data = data {
                completion(try? JSONDecoder().decode(T.self, from: data))
            } else {
                completion(nil)
            }
        }
    }
    
}


//        let key = url.absoluteString
//
//        if let data = cache.getData(key: key as NSString) as? Data {
//            completion(UIImage(data: data))
//        } else {
//            dataLoader.downloadWithURL(url: url)
//                .onSuccess { (data) in
//                    completion(UIImage(data: data))
//                }.onFail { (error) in
//                    completion(nil)
//            }
//       }

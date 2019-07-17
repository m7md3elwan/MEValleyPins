//
//  MEValleyLoader.swift
//  MEValleyLoader
//
//  Created by Mohamed Mostafa on 7/15/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import Foundation

public enum Result<T> {
    case success(T)
    case fail(Error)
}

public protocol DataFetcherable {
    func getData(with url: URL, cached: Bool, completion: @escaping (Result<Data>) -> Void)
}

public protocol ImageFetcherable {
    func getImage(with url: URL, completion: @escaping (UIImage?) -> Void)
}

public protocol DecodableFetcherable {
    func getObject<T: Decodable>(with url: URL, cached: Bool, completion: @escaping (Result<T>) -> (Void))
}

open class MEValleyLoader {
    
    // MARK:- Properties
    var cache: MECachable
    var dataLoader: MEDownloadable
    
    public static let shared = MEValleyLoader()
    
    // MARK:- Init
    init(cache: MECachable = MECache(), dataLoader: MEDownloadable = MEDownloader()) {
        self.cache = cache
        self.dataLoader = dataLoader
    }
    
    // MARK:- Methods
    // MARK: Public methods
    public func getData(with url: URL, cached: Bool = true, completion: @escaping (Result<Data>) -> Void) {
        let key = url.absoluteString
        
        if let data = cache.getData(key: key as NSString) as? Data, cached == true {
            completion(Result.success(data))
        } else {
            dataLoader.downloadWithURL(url: url)
                .onSuccess { (data) in
                    self.cache.set(data: data, key: key as NSString)
                    completion(Result.success(data))
                }.onFail { (error) in
                    completion(Result.fail(error))
            }
        }
    }
}

extension MEValleyLoader: ImageFetcherable {
    public func getImage(with url: URL, completion: @escaping (UIImage?) -> Void) {
        getData(with: url) { (result) in
            switch result {
            case .success(let data):
                completion(UIImage(data: data))
            case .fail(_):
                completion(nil)
            }
        }
    }
}

extension MEValleyLoader: DecodableFetcherable {
    public func getObject<T: Decodable>(with url: URL, cached: Bool = true, completion: @escaping (Result<T>) -> (Void)) {
        getData(with: url, cached: cached) { (result) in
            switch result {
            case .success(let data):
                if let object = try? JSONDecoder().decode(T.self, from: data) {
                    completion(Result.success(object))
                } else {
                    completion(Result.fail(NSError(domain: "MEValleyLoader", code: 1, userInfo: nil)))
                }
            case .fail(let error):
                completion(Result.fail(error))
            }
        }
    }
}

//
//  MEDownloadRequest.swift
//  MEValleyLoader
//
//  Created by Mohamed Mostafa on 7/15/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import Foundation

public class MEDownloadRequest {
    
    public typealias SuccessCallback = (Data) -> Void
    public typealias FailureCallback = (Error) -> Void
    
    
    var successCompletion: SuccessCallback?
    var failureCompletion: FailureCallback?
    
    weak var task: MEDownloadTask?
    
    init(task: MEDownloadTask) {
        self.task = task
        self.task?.addRequest(request: self)
    }
    
    func cancel() {
        self.task?.removeRequest(request: self)
    }
    
    @discardableResult
    public func onSuccess( _ completion:  @escaping SuccessCallback) -> Self {
        successCompletion = completion
        return self
    }
    
    @discardableResult
    public  func onFail( _ completion:  @escaping FailureCallback) -> Self {
        failureCompletion = completion
        return self
    }
}

public class MEDownloadTask: NSObject {
    
    // MARK:- Properties
    private weak var manager: MEDownloader?
    
    public var url: URL
    var data = Data()
    var downloadTask: URLSessionDataTask?
    private var requests = [MEDownloadRequest]() {
        didSet {
            if requests.isEmpty {
                downloadTask?.cancel()
                self.manager?.removeTask(task: self)
            }
        }
    }
    
    // MARK:- Init
    public init(url: URL, manager:MEDownloader) {
        self.url = url
        self.manager = manager
        self.downloadTask = manager.session.dataTask(with: url)
    }
    
    // MARK:- Methods
    // MARK: Public Methods
    public func start() {
        downloadTask?.resume()
    }
    
    public func addRequest(request: MEDownloadRequest) {
        requests.append(request)
    }
    
    public func removeRequest(request: MEDownloadRequest) {
        if let index = (requests.firstIndex{ $0 === request }) {
            requests.remove(at: index)
        }
    }
    
    public func taskSuccessed(data: Data) {
        for request in requests {
            request.successCompletion?(data)
        }
    }
    
    public func taskFailed(error: Error) {
        for request in requests {
            request.failureCompletion?(error)
        }
    }
    
}

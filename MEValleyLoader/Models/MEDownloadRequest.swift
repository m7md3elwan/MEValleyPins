//
//  MEDownloadRequest.swift
//  MEValleyLoader
//
//  Created by Mohamed Mostafa on 7/15/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import Foundation

/**
 `MEDownloadRequest` act as initiators to download a URL, returned to user so he can cancel request if needed without knowing extra details
 */
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

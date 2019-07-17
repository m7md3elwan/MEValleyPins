//
//  Dispatch+helpers.swift
//  MEValleyPins
//
//  Created by Mohamed Mostafa on 7/17/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import Foundation

class Dispatch: NSObject {
    
    /**
     Swift wrapper around dispatch_after
     
     - parameter time:    The time, in seconds, to delay
     - parameter closure: The closure to call after `delay` has passed
     */
    class func after(_ time: TimeInterval, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
            closure()
        })
    }
    
    /**
     Swift wrapper for dispatching onto the main thread.
     
     - parameter closure: The closure to run on the main thread.
     */
    class func onMainThread(_ closure: @escaping () -> ()) {
        if Thread.isMainThread {
            closure()
            return
        }
        
        DispatchQueue.main.async(execute: {
            closure()
        })
    }
    
}

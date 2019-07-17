//
//  PinsService.swift
//  MEValleyPins
//
//  Created by Mohamed Mostafa on 7/17/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import Foundation
import MEValleyLoader

protocol PinsFetcher {
    func getPins(page:Int, completion:@escaping(_ pins:[Pin]?,_ error: Error?)-> Void)
}

class PinService: PinsFetcher {

    // MARK:- Constants
    struct Constants {
        static let url = "https://pastebin.com/raw/wgkJgazE"
    }
    
    var objectFetcher: DecodableFetcherable!
    
    init(objectFetcher: DecodableFetcherable = MEValleyLoader.shared) {
        self.objectFetcher = objectFetcher
    }
    
    // MARK:- Methods
    // MARK: Public functions
    func getPins(page:Int, completion:@escaping(_ pins:[Pin]?,_ error: Error?)-> Void){
        objectFetcher!.getObject(with: URL(string: Constants.url)!, cached: false) { (result: Result<[Pin]>) -> (Void) in
            switch result {
            case .success(let pins):
                completion(pins, nil)
            case .fail(let error):
                completion(nil, error)
            }
        }
    }
    
}

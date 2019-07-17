//
//  PaginatedDataLoadState.swift
//  MEValleyPins
//
//  Created by Mohamed Mostafa on 7/17/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import Foundation

enum PaginatedDataLoadState<T> {
    case notLoaded
    case loading
    case paging([T], nextPage: Int)
    case populated([T])
    
    var data: [T] {
        switch self {
        case .paging(let data, _ ):
            return data
        case .populated(let data):
            return data
        case .loading, .notLoaded:
            return []
        }
    }
    
    var nextPage: Int {
        switch self {
        case .paging(_, let nextPage):
            return nextPage
        case .populated(_):
            return 1
        case .loading, .notLoaded:
            return 1
        }
    }
    
    var isEmpty: Bool {
        switch self {
        case .paging(let data, _ ):
            return data.isEmpty
        case .populated(let data):
            return data.isEmpty
        case .loading, .notLoaded:
            return false
        }
    }
    
    var hasNextPage: Bool {
        switch self {
        case .paging(_, _ ):
            return true
        case .populated(_):
            return false
        case .loading, .notLoaded:
            return true
        }
    }
    
    var isPopulated: Bool {
        switch self {
        case .paging(_, _ ):
            return false
        case .populated(_):
            return true
        case .loading, .notLoaded:
            return false
        }
    }
    
    var isLoading: Bool {
        switch self {
        case .paging(_, _ ):
            return false
        case .populated(_):
            return false
        case .loading:
            return true
        case .notLoaded:
            return false
        }
    }
}

//
//  MEDownloadable.swift
//  MEValleyLoader
//
//  Created by Mohamed Mostafa on 7/15/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import Foundation

protocol MEDownloadable {
    func downloadWithURL(url: URL) -> MEDownloadRequest
    func removeTask(task: MEDownloadTask)
}

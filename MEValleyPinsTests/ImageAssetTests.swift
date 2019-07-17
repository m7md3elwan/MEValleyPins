//
//  ImageAssetTests.swift
//  MEValleyPinsTests
//
//  Created by Mohamed Mostafa on 7/17/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import XCTest
import Quick
import Nimble

@testable import MEValleyPins

class ImageAssetTests: QuickSpec {
    override func spec() {
        describe("Testing ImageAsset") {
            context("Has images in ImageAsset") {
                it("Has non nil Image") {
                    for image in ImageAsset.allCases {
                        expect(UIImage(asset: image)).toNot(beNil(), description: "make sure to add \"\(image)\" in assets")
                    }
                }
            }
        }
    }
}

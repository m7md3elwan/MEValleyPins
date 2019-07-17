//
//  StringExtension.swift
//  HEXColor-iOS
//
//  Created by Sergey Pugach on 2/2/18.
//  Copyright © 2018 P.D.Q. All rights reserved.
//

import Foundation
import UIKit

extension String {
    /**
     Convert argb string to rgba string.
     */
    public var argb2rgba: String? {
        guard self.hasPrefix("#") else {
            return nil
        }
        
        let hexString: String = String(self[self.index(self.startIndex, offsetBy: 1)...])
        switch hexString.count {
        case 4:
            return "#\(String(hexString[self.index(self.startIndex, offsetBy: 1)...]))\(String(hexString[..<self.index(self.startIndex, offsetBy: 1)]))"
        case 8:
            return "#\(String(hexString[self.index(self.startIndex, offsetBy: 2)...]))\(String(hexString[..<self.index(self.startIndex, offsetBy: 2)]))"
        default:
            return nil
        }
    }
}

func generateAttributtedText(text: String, color: UIColor, font: UIFont) -> NSMutableAttributedString {
    let defaultAttributes = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font]
    let attributedString = NSMutableAttributedString(string: text , attributes: defaultAttributes)
    return attributedString
}

func applyAttributeTo(mutableString: NSMutableAttributedString, regex: String, attributes: [NSAttributedString.Key : NSObject], discardableText: [String]) -> NSMutableAttributedString {
    let htmlTagRegex: NSRegularExpression = try! NSRegularExpression.init(pattern: regex, options: .caseInsensitive)
    let arrayOfAllTags: [NSTextCheckingResult] = htmlTagRegex.matches(in: mutableString.string, options:.withoutAnchoringBounds, range: NSRange(location: 0, length: mutableString.length))
    for result in arrayOfAllTags {
        mutableString.addAttributes(attributes, range: result.range)
    }
    
    for item in discardableText {
        while mutableString.string.contains(item) {
            let range = mutableString.mutableString.range(of: item)
            mutableString.replaceCharacters(in: range, with: "")
        }
    }
    
    return mutableString
}

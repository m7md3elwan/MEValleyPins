//
//  UIView+cornerRadius.swift
//  MEValleyPins
//
//  Created by Mohamed Mostafa on 7/16/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius}
        set { layer.cornerRadius =  newValue
            layer.masksToBounds = newValue > 0
        }
    }
}

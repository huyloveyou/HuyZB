//
//  UIColor.Extension.swift
//  HuyZB
//
//  Created by mac on 2018/5/29.
//  Copyright © 2018年 come.huy. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
        self.init(red : r / 255.0, green : g / 255.0, blue : b / 255.0, alpha: 1.0)
    }
}

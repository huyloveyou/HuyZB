//
//  UIBarButtonItem.extension.swift
//  HuyZB
//
//  Created by mac on 2018/5/26.
//  Copyright © 2018年 come.huy. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem{
    convenience init(imageName : String, highImageName : String = "", size : CGSize = CGSize.zero){
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highImageName != "" {
        btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        if size == CGSize.zero{
            btn.sizeToFit()
        }else{
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        self.init(customView : btn)
    }
}

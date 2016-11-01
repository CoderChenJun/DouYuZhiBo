//
//  UIcolor-Extension(CJ).swift
//  DouYuZhiBo
//
//  Created by Jingjing Huang on 16/11/1.
//  Copyright © 2016年 ChenJun. All rights reserved.
//

import Foundation
import UIKit


extension UIColor {
    
    /**
     *  扩充-便利构造函数 : 只要传入RGB即可
     */
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
    
    
    
}


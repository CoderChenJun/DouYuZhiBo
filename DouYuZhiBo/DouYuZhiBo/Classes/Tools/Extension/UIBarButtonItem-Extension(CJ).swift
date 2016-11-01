//
//  UIBarButtonItem-Extension(CJ).swift
//  DouYuZhiBo
//
//  Created by Jingjing Huang on 16/11/1.
//  Copyright © 2016年 ChenJun. All rights reserved.
//

import Foundation

import UIKit

extension UIBarButtonItem {
    
    
    
//    // 扩充-类方法
//    class func createItem(imageName : String, highImageName : String, size : CGSize) -> UIBarButtonItem {
//        
//        let btn = UIButton()
//        btn.setImage(UIImage(named: imageName), forState: .Normal)
//        btn.setImage(UIImage(named: highImageName), forState: .Highlighted)
//        btn.frame = CGRect(origin: CGPointZero, size: size)
//        return UIBarButtonItem(customView: btn)
//    }
    
    
    
    
    /**
     *  扩充-便利构造函数 : 1>必须以convenience开头
     *                   2>在构造函数中必须明确调用一个设计的构造函数(使用self进行调用)
     *
     *  @param String Normal 图片名
     *  @param String High   图片名
     *  @param CGSize 按钮    尺寸
     *
     *  @return Item
     */
    convenience init(imageName : String, highImageName : String = "", size : CGSize = CGSizeZero) {
        // 1.创建UIButton
        let btn = UIButton()
        
        // 2.设置btn图片
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), forState: .Highlighted)
        }
        
        // 3.这是btn尺寸
        if size == CGSizeZero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPointZero, size: size)
        }
        
        // 4.创建UIBarButtonItem
        self.init(customView: btn)
    }
    
    
    
    
}











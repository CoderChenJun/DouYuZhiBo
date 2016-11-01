//
//  CJMainViewController.swift
//  DouYuZhiBo
//
//  Created by Jingjing Huang on 16/10/31.
//  Copyright © 2016年 ChenJun. All rights reserved.
//

import UIKit

class CJMainViewController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVc("Home")
        addChildVc("Live")
        addChildVc("Follow")
        addChildVc("Profile")
        
    }
    
    
    
    
    
    
    
    
    private func addChildVc(storyboardName : String){
        
        // 1.通过storyboard获取控制器
        let childVc1 = UIStoryboard(name : storyboardName, bundle : nil).instantiateInitialViewController()!
        
        // 2.将childVC作为子控制器
        addChildViewController(childVc1)
        
    }
    
    
    
    
    
    
    
    
    
}

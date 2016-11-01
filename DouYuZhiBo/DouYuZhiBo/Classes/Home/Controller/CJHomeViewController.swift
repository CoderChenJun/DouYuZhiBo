//
//  CJHomeViewController.swift
//  DouYuZhiBo
//
//  Created by Jingjing Huang on 16/11/1.
//  Copyright © 2016年 ChenJun. All rights reserved.
//

import UIKit

class CJHomeViewController: UIViewController {
    
    override func viewDidLoad() {
        
        // 设置UI界面
        setupUI()
        
        
    }

}





// Mark - 设置UI界面
extension CJHomeViewController {
    
    
    private func setupUI() {
        // 1.设置导航栏
        setupNavigationBar()
        
    }
    
    
    
    private func setupNavigationBar() {
        
        // 1.设置左侧Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        
        
        
        
        
        
        // 2.设置右侧Item
        
        let size = CGSize(width: 35, height: 35)
        
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_click", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        
//        let historyItem = UIBarButtonItem.createItem("image_my_history", highImageName: "Image_my_history_click", size: size)
//        let searchItem = UIBarButtonItem.createItem("btn_search", highImageName: "btn_search_click", size: size)
//        let qrcodeItem = UIBarButtonItem.createItem("Image_scan", highImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
        
        
    }
    
    
    
    
}










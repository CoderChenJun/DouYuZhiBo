//
//  CJHomeViewController.swift
//  DouYuZhiBo
//
//  Created by Jingjing Huang on 16/11/1.
//  Copyright © 2016年 ChenJun. All rights reserved.
//

import UIKit


private let CJ_TitleViewH : CGFloat = 40



class CJHomeViewController: UIViewController {
    
    // MARK - 懒加载属性 - CJPageTitleView
    private lazy var pageTitleView : CJPageTitleView = {
        
        let titleFrame = CGRect(x: 0, y: CJ_StatusBarH + CJ_NavigationBarH, width: CJ_ScreenW, height: CJ_TitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = CJPageTitleView(frame: titleFrame, titles: titles)
        return titleView
        
    }()
    
    
    // MARK - 懒加载属性 - CJPageTitleView
    private lazy var pageContentView : CJPageContentView = {
        
        // 1.确定内容的frame
        let contentH = CJ_ScreenH - CJ_StatusBarH - CJ_NavigationBarH - CJ_TitleViewH
        let contentFrame = CGRect(x: 0, y: CJ_StatusBarH + CJ_NavigationBarH + CJ_TitleViewH, width: CJ_ScreenW, height: contentH)
        
        
        // 2.确定所有的子控制器
        var childVcs = [UIViewController]()
        for _ in 0..<4 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.init(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        
        let contentView = CJPageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        
        return contentView
        
    }()
    
    
    
    
    
    
    
    
    // MARK - 系统回调函数
    override func viewDidLoad() {
        
        // 设置UI界面
        setupUI()
        
    }

    
    
}








// MARK - 设置UI界面
extension CJHomeViewController {
    
    
    private func setupUI() {
        
        // 0.不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        // 1.设置导航栏
        setupNavigationBar()
        
        // 2.添加TitleView
        view.addSubview(pageTitleView)
        
        
        // 3.添加ContentView
        view.addSubview(pageContentView)
        
        
    }
    
    
    private func setupNavigationBar() {
        
        // 1.设置左侧Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        // 2.设置右侧Item
        
        let size = CGSize(width: 35, height: 35)
        
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_click", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
        
    }
    
    
    
    
}










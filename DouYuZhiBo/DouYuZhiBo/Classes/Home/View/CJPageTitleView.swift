 //
//  CJPageTitleView.swift
//  DouYuZhiBo
//
//  Created by Jingjing Huang on 16/11/1.
//  Copyright © 2016年 ChenJun. All rights reserved.
//

import UIKit


private let CJ_scrollLineH : CGFloat = 2



class CJPageTitleView: UIView {
    
    // MARK - 定义属性
    private var titles : [String]
    
    
    
    
    // MARK - 懒加载属性 - titleLabels
    private lazy var titleLabels : [UILabel] = [UILabel]()
    
    
    // MARK - 懒加载属性 - scrollView
    private lazy var scrollView : UIScrollView = {
        
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
        
    }()
    
    // MARK - 懒加载属性 - scrollLine
    private lazy var scrollLine : UIView = {
        
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orangeColor()
        return scrollLine
        
    }()
    
    
    
    // MARK - 自定义构造函数
    init(frame: CGRect, titles : [String]) {
        self.titles = titles
        super.init(frame : frame)
        
        // 设置UI界面
        setupUI()
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
 
 
 
 
/**
 *  设置UI界面
 */
extension CJPageTitleView {
    
    
    
    private func setupUI() {
        
        // 1.添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 2.添加title对应的label
        setupTitleLabels()
        
        
        // 3.设置底线和滚动条
        setupBottomLineAndScrollLine()
    }
    
    
    
    /**
     *  添加title对应的label
     */
    private func setupTitleLabels() {
        
        // 0.设置Label的一些 固定的frame值
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - CJ_scrollLineH
        let labelY : CGFloat = 0
        
        for(index, title) in titles.enumerate() {
            //  1.创建UILabel
            let label = UILabel()
            
            // 2.设置Label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFontOfSize(16.0)
            label.textColor = UIColor.darkGrayColor()
            label.textAlignment = .Center
            
            // 3.这是Label的frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            // 4.将Label添加到scrollView中
            scrollView.addSubview(label)
            
            titleLabels.append(label)
            
        }
        
    }
    
    
    /**
     *  设置底线和滚动条
     */
    private func setupBottomLineAndScrollLine() {
        
        // 1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGrayColor()
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        
        
        // 2.添加scrollView
        // 2.1获取第一个Label
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor.orangeColor()
        
        
        // 2.2设置scrollView属性
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - CJ_scrollLineH, width: firstLabel.frame.width, height: CJ_scrollLineH)
        scrollView.addSubview(scrollLine)
        
        
        
    }
    
}
 
 
 
 
 
 
 
 
 
 
 

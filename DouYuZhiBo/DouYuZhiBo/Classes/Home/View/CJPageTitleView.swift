 //
//  CJPageTitleView.swift
//  DouYuZhiBo
//
//  Created by Jingjing Huang on 16/11/1.
//  Copyright © 2016年 ChenJun. All rights reserved.
//

import UIKit
 
 
 
// MARK - 定义常量
private let CJ_scrollLineH : CGFloat = 2
private let CJ_NormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let CJ_SelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)
 
 
 
// MARK - 定义协议
protocol CJPageTitleViewDelegate : class {

    func pageTitleView(titleView : CJPageTitleView, selectedIndex index : Int)

}
 
 

 
// MARK - 定义CJPageTitleView
class CJPageTitleView: UIView {
    
    // MARK - 定义属性
    private var titles : [String]
    private var currentIndex : Int = 0
    weak var delegate : CJPageTitleViewDelegate?
    
    
    
    
    
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
        scrollLine.backgroundColor = UIColor(r: CJ_SelectColor.0, g: CJ_SelectColor.1, b: CJ_SelectColor.2)
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
            label.textColor = UIColor(r: CJ_NormalColor.0, g: CJ_NormalColor.1, b: CJ_NormalColor.2)
            label.textAlignment = .Center
            
            // 3.这是Label的frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            // 4.将Label添加到scrollView中
            scrollView.addSubview(label)
            
            titleLabels.append(label)
            
            
            // 5.给Label添加手势
            label.userInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(_:)))
            label.addGestureRecognizer(tapGes)
            
            
        }
        
    }
    
    
    /**
     *  设置底线和滚动条
     */
    private func setupBottomLineAndScrollLine() {
        
        // 1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor(r: CJ_NormalColor.0, g: CJ_NormalColor.1, b: CJ_NormalColor.2)
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        // 2.添加scrollView
        // 2.1获取第一个Label
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor(r: CJ_SelectColor.0, g: CJ_SelectColor.1, b: CJ_SelectColor.2)
        
        // 2.2设置scrollView属性
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - CJ_scrollLineH, width: firstLabel.frame.width, height: CJ_scrollLineH)
        scrollView.addSubview(scrollLine)
        
    }
    
}
 
 
 
 
 
 
 
 
 
// Mark - 监听Label的点击
extension CJPageTitleView {
    
    @objc private func titleLabelClick(tapGes : UITapGestureRecognizer) {
        
        // 1.获取当前Label
        guard let currentLabel = tapGes.view as? UILabel else { return }
        
        // 2.获取之前Label
        let oldLabel = titleLabels[currentIndex]
        
        // 3.切换文字颜色
        currentLabel.textColor = UIColor(r: CJ_SelectColor.0, g: CJ_SelectColor.1, b: CJ_SelectColor.2)
        oldLabel.textColor = UIColor(r: CJ_NormalColor.0, g: CJ_NormalColor.1, b: CJ_NormalColor.2)
        
        
        // 4.保存最新的Label下标值
        currentIndex = currentLabel.tag
        
        
        // 5.滚动条位置改变
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animateWithDuration(0.15) { 
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        
        
        // 6.通知代理
        delegate?.pageTitleView(self, selectedIndex: currentIndex)
        
    }
    
}
 
 
 
 
 
 
// MARK - 对外暴露的方法
extension CJPageTitleView {

    func setTitleWithProgress(progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        
        // 1.取出sourceLabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        
        // 2.处理滑块逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        
        
        // 3.颜色的渐变(复杂)
        // 3.1.取出变化的范围
        let colorDelta = (CJ_SelectColor.0 - CJ_NormalColor.0,CJ_SelectColor.1 - CJ_NormalColor.1,CJ_SelectColor.2 - CJ_NormalColor.2)
        
        // 3.2.变化sourceLabel
        sourceLabel.textColor = UIColor(r: CJ_SelectColor.0 - colorDelta.0 * progress, g: CJ_SelectColor.1 - colorDelta.1 * progress, b: CJ_SelectColor.2 - colorDelta.2 * progress)
        
        // 3.3.变化targetLabel
        targetLabel.textColor = UIColor(r: CJ_NormalColor.0 + colorDelta.0 * progress, g: CJ_NormalColor.1 + colorDelta.1 * progress, b: CJ_NormalColor.2 + colorDelta.2 * progress)
        
        
        
        
        // 4.记录最新的index(!必须!)
        currentIndex = targetIndex
        
        
    }

}

 
 
 
 
 
 
 
 

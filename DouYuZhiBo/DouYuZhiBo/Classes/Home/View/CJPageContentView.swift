 //
//  CJPageContentView.swift
//  DouYuZhiBo
//
//  Created by Jingjing Huang on 16/11/1.
//  Copyright © 2016年 ChenJun. All rights reserved.
//

import UIKit


 
protocol CJPageContentViewDelegate : class {

    func pageContentView(contentView : CJPageContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)

}
 
 
 
 
 
 
private let ContentCellID = "ContentCellID"
 
 
class CJPageContentView: UIView {
    
    
    // MARK - 定义属性
    private var childVcs : [UIViewController]
    private weak var parentViewController : UIViewController?
    private var startOffsexX : CGFloat = 0
    weak var delegate : CJPageContentViewDelegate?
    private var isForbidScrollDelegate : Bool = false
    
    
    // MARK - 懒加载属性 - collectionView
    private lazy var collectionView : UICollectionView = {[weak self] in
        
        // 1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .Horizontal
        
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.pagingEnabled = true
        collectionView.bounces = false
        collectionView.scrollsToTop = false
        
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "ContentCellID")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
        
    }()
    
    
    // MARK - 自定义构造函数
    init(frame: CGRect, childVcs : [UIViewController], parentViewController : UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        
        // 设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

 
 

 
// MARK - 设置UI界面
extension CJPageContentView {

    private func setupUI() {
    // 1.将所有的子控制器添加到父控制器中
    for childVc in childVcs {
        parentViewController?.addChildViewController(childVc)
    }
    
    // 2.添加UICollectionView，用于在cell中存放控制器的View
    collectionView.frame = bounds
    addSubview(collectionView)
    }

}
 
 
 
 

// MARK - 遵守UICollectionViewDataSource
extension CJPageContentView : UICollectionViewDataSource {

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }




    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // 1.创建cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ContentCellID, forIndexPath: indexPath)
        
        
        
        // 2.给cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }


}
 
 
 
 
 
 // MARK - 遵守UICollectionViewDelegate
extension CJPageContentView : UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        
        startOffsexX = scrollView.contentOffset.x
        
    }
    
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        // 0.判断是否是点击事件
        if isForbidScrollDelegate {
            return
        }
        
        
        // 1.先定义获取需要的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        
        // 2.判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
        if currentOffsetX > startOffsexX { // 左滑
            
            // 2.1.计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            // 2.2.计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            // 2.3.计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            // 如果完全划过去
            if currentOffsetX - startOffsexX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
            
            
        } else { // 右滑
            
            // 2.1.计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            // 2.2.计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            // 2.3.计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        
        
        
        // 3.将progress/sourceIndex/targetIndex传递给titleView
        delegate?.pageContentView(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
    
}
 
 
 
 
// MARK - 对外暴露的方法
extension CJPageContentView {
    
    func setCurrentIndex(currentIndex : Int) {
        
        // 1.记录需要禁止执行的代理方法
        isForbidScrollDelegate = true
        
        // 2.滚动到正确的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX,y: 0), animated: false)
    }

}
 
 
 
 
 
 

 
 
 
 
 
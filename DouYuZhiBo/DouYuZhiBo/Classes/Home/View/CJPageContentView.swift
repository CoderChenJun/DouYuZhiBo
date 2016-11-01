 //
//  CJPageContentView.swift
//  DouYuZhiBo
//
//  Created by Jingjing Huang on 16/11/1.
//  Copyright © 2016年 ChenJun. All rights reserved.
//

import UIKit


private let ContentCellID = "ContentCellID"
 
 
class CJPageContentView: UIView {
    
    
    // MARK - 定义属性
    private var childVcs : [UIViewController]
    private var parentViewController : UIViewController
    
    
    
    
    // MARK - 懒加载属性 - collectionView
    private lazy var collectionView : UICollectionView = {
        
        // 1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .Horizontal
        
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.pagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "ContentCellID")
        
        return collectionView
        
    }()
    
    
    
    
    
    
    
    // MARK - 自定义构造函数
    init(frame: CGRect, childVcs : [UIViewController], parentViewController : UIViewController) {
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
        parentViewController.addChildViewController(childVc)
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
 
 
 

 
 
 
 
 
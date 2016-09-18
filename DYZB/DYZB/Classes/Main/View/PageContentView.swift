//
//  PageContentView.swift
//  DYZB
//
//  Created by 吕昱坪 on 16/9/18.
//  Copyright © 2016年 吕昱坪. All rights reserved.
//

import UIKit


private let ContentCellID = "ContentCellID"
class PageContentView: UIView {
    
    //MARK:定义属性
    private var childVcs: [UIViewController]
    private  weak var parentViewController : UIViewController?
    
    //MARK:懒加载属性
    private lazy var collectionView : UICollectionView = {
        //1.创建layout 设置流水布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .Horizontal
        
        //2.创建UICollectionView
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false//水平方向指示器
        collectionView.pagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        //获取类的类型用.self
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
    }()

   //MARK:自定义构造函数
    init(frame: CGRect, childVcs: [UIViewController],parentViewController: UIViewController) {
        
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        
        //设置UI
        setupUI()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK:- 设置UI界面
extension PageContentView {
    
    private func setupUI() {
        
        //1.将所有子控制器添加到父控制器中
        for childVc in childVcs {
            
            parentViewController?.addChildViewController(childVc)
        }
        
        //2.添加UICollectionView，用于在Cell中存放控制器的View
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

//MARK:- 遵守UICollectionViewDataSource
extension PageContentView: UICollectionViewDataSource{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //1.创建Cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ContentCellID, forIndexPath: indexPath)
        
        //2.给Cell设置内容
        for view in cell.contentView.subviews {
            
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}





















//
//  RecommendViewController.swift
//  DYZB
//
//  Created by 吕昱坪 on 16/9/18.
//  Copyright © 2016年 吕昱坪. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW  = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH  = kItemW * 3 / 4
//private let kNormalItemH  = kItemW * 4 / 3
private let kPrettyItemH  = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50


private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"
private let kHeaderViewID = "kHeaderViewID"


class RecommendViewController: UIViewController {
    //MARK: - 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
         layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
       
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        //2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds,
            collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            
          
        
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)

        
        return collectionView
        
        }()
    
    //MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI界面
        setupUI()
        
    }
}
//MARK: - 设置UI界面的内容
extension RecommendViewController {
    
    fileprivate func setupUI() {
    
    //1.将UICollectionView添加到控制器的View中
        view.addSubview(collectionView)
    }
}

extension RecommendViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            
            return 8
            
        }
        
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.定义Cell
        var cell: UICollectionViewCell!
        
        //2.取出cell
        if (indexPath as NSIndexPath).section == 1 {
            
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath)
        }else {
            
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出section的HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath)
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if (indexPath as NSIndexPath).section == 1 {
            
            return CGSize(width: kItemW, height: kPrettyItemH)
        
        }
        
             return CGSize(width: kItemW, height: kNormalItemH)
    }
}









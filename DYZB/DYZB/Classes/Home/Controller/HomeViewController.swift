//
//  HomeViewController.swift
//  DYZB
//
//  Created by 吕昱坪 on 16/9/17.
//  Copyright © 2016年 吕昱坪. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.setupUI()
      
        
    }
}

//MARK--设置UI界面
extension HomeViewController {
    
    //swift中的访问修饰符
    //private 访问级别所修饰的属性或者方法只能在当前的Swift源文件中可以访问
    //internal 访问级别所修饰的属性或者方法在源代码所在的整个模块都可以访问
    //public可以被任何人使用
    private func setupUI() {
       //设置导航栏
       setupNavigationBar()
    }
    
    
    private func setupNavigationBar(){
        //1.设置左侧的Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        //2.设置右侧的Item
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", hightImageName: "image_my_history", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", hightImageName: "btn_search", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", hightImageName: "Image_scan", size: size)
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
    }
}

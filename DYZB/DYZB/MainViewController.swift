//
//  ViewController.swift
//  DYZB
//
//  Created by 吕昱坪 on 16/9/16.
//  Copyright © 2016年 吕昱坪. All rights reserved.
//

import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVc("Home")
        addChildVc("Live")
        addChildVc("Follow")
        addChildVc("profile")
    }
    
    //抽取添加子控制器的方法
    private func addChildVc(storyName: String) {
        
        //通过storyboard获取控制器
        let childVc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()! //可选类型 !可选类型强制解包就是确定类型
        
        //将childV作为子控制器
        addChildViewController(childVc)//这里要传入确定类型 类型不一致  对可选类型进行解包

    }
}


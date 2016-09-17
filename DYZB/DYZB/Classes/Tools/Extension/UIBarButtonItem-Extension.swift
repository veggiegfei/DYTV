//
//  UIBarButtonItem-Extension.swift
//  DYZB

//对UIBarButtonItem做扩展，扩展class开头的类方法，可以直接通过类来调用

import UIKit

extension UIBarButtonItem {
    /*抽取类方法
    class func creatItem(imageName: String, hightImageName: String, size: CGSize) ->UIBarButtonItem {
        
        
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        btn.setImage(UIImage(named: hightImageName), forState: .Highlighted)
        btn.frame = CGRect(origin: CGPointZero, size: size)
        
        return UIBarButtonItem(customView: btn)
    }
*/
    
    //swift中强烈建议用构造函数  
    //构造函数以init开头，不需要写返回值，extension中对系统类扩充构造函数，只能扩充便利构造函数。
    //便利构造函数: 1>必须以convenience开头 2>在构造函数中必须明确调用一个设计的构造函数(self)
    //Swift语法 String = "",表示相传就传，不想穿就为空;size: CGSize = CGSizeZero表示有CGSize就传，没有就传CGSizeZero
   convenience init(imageName: String, hightImageName: String = "", size: CGSize = CGSizeZero) {
        //1.创建UIbutton
        let btn = UIButton()
    
        //2.设置button的图片
        btn.setImage(UIImage(named: imageName), forState: .Normal)
    if hightImageName != ""{
        btn.setImage(UIImage(named: hightImageName), forState: .Highlighted)
    }
    
       //3.设置btn的尺寸
    if size == CGSizeZero {
        btn.sizeToFit()
    }else{
        btn.frame = CGRect(origin: CGPointZero, size: size)
    }
    
    //4.创建UIBarButtonItem
    self.init(customView: btn)
    }
}





























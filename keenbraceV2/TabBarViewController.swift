//
//  TabBarViewController.swift
//  keenbraceV2
//
//  Created by michaeltam on 15/12/31.
//  Copyright © 2015年 michaeltam. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    var selectButton:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.tabBar.backgroundImage     = UIImage(named: "korean")
        
        
        
        self.viewControllers?.count
        print(self.viewControllers?.count)
        
        
        print(self.tabBar.frame)
        
        
        let rect = self.tabBar.frame
        self.tabBar.removeFromSuperview()
        
        // 用记录下的frame建立一个UIView
        let myView = UIView(frame: rect)
        
        
        myView.frame = CGRectMake(myView.frame.origin.x, myView.frame.origin.y - 20, myView.frame.size.width, myView.frame.size.height + 20)
        
        // 设置这个View的背景色
//        myView.backgroundColor = UIColor(patternImage: UIImage(named: "korean")!)
        myView.backgroundColor = UIColor.lightGrayColor()
        myView.backgroundColor = UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha:1.0)
        self.view.addSubview(myView)
        
        
        func imageResize(image:UIImage, newHeight:CGFloat) -> UIImage{
            let width = image.size.width
            let height = image.size.height
            let imageRatio = width / height
            
            let rect = CGRectMake(0.0, 0.0, newHeight * imageRatio, newHeight)
            UIGraphicsBeginImageContext(rect.size)
            image.drawInRect(rect)
            let imageCopy = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return imageCopy
        }
        
        
        for var i = 0; i < self.viewControllers?.count; i++ {
            
            let button = UIButton()
            
            // 根据子ViewController的个数计算Button的宽度
            let width = myView.frame.size.width / CGFloat(self.viewControllers!.count)
            let x = CGFloat(i) * width
            button.frame = CGRectMake(x, 0, width, myView.frame.size.height)
            
            // 设置Button未选中时候的图标
            var tempImage = UIImage(named: "TabBar\(i)")
            if i == 0 {
                tempImage = imageResize(tempImage!, newHeight: 35)
            }
            if i == 1 {
                tempImage = imageResize(tempImage!, newHeight: 65)
            }
            if i == 2 {
                tempImage = imageResize(tempImage!, newHeight: 35)
            }
            
            
            
            let image = tempImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
//            let image = UIImage(named: "TabBar\(i)")
            button.setImage(image, forState: UIControlState.Normal)
            
            // 设置Button选中时候的图标，注意这里Button的状态是Selected，而不是Highlighted
            let selImage = UIImage(named: "TabBar\(i)Sel")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            button.setImage(selImage, forState: UIControlState.Selected)
            
            // 设置Button未选中和选中时候的背景图
            button.setBackgroundImage(UIImage(named: "TabBarBG"), forState: UIControlState.Normal)
//            button.setBackgroundImage(UIImage(named: "TabBarBGSel"), forState: UIControlState.Selected)
            button.setBackgroundImage(UIImage(named: "TabBarBGSel"), forState: UIControlState.Selected)
            
            
            
            // 去掉UIButton自带的高光效果
            button.adjustsImageWhenHighlighted = false
            
            myView.addSubview(button)
            
            // 设置UIButton的标记
            button.tag = i
            
            button.addTarget(self, action: "onClick:", forControlEvents: UIControlEvents.TouchUpInside)
            
            // 设置默认的选中项
            if i == 0 {
                button.selected = true
                self.selectButton = button
            }
        }
        
    }

    func onClick(button: UIButton) {
        // 将上个选中按钮设置为未选中
        self.selectButton.selected = false
        // 当前按钮设置为选中
        button.selected = true
        // 记录选中按钮
        self.selectButton = button
        
        // 通过UITabBarController的selectedIndex属性设置选中了哪个UIViewController
        self.selectedIndex = button.tag
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

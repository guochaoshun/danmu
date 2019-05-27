
//
//  DanMuManager.swift
//  第三方库学习
//
//  Created by 郭朝顺 on 2018/7/26星期四.
//  Copyright © 2018年 智网易联. All rights reserved.
//

import UIKit


// 今天突然发现有个第三库BarrageRenderer,有机会看看  https://github.com/unash/BarrageRenderer


// 本来想做成单例,但是想想可能没有必要,就让DanMuManager和ViewController的生命周期一致就行,作为ViewController的属性就行了
class DanMuManager {
    
    var allViewArray = [FlyLabelView]()
    
    func showDanMu( num : String , fatherView : UIView = UIApplication.shared.keyWindow! )  {
        
        let view = getAvailableFlyLabelView()
        
        
        // 进行弹道的区分,
        // 有缺陷,弹幕可能会有重叠的情况: 解决方法有以下几种.
        // 应该再有一个方法来获取可用的弹道,把新弹幕优先加入新弹道中;
        // 弹幕实在太多的情况,就需要有选择的处理弹幕,当前登录的用户在自己的屏幕上肯定加入,剩余其他人的弹幕,有选择的加入部分;
        // 弹幕的速度也要是可变的,长弹幕快点消失,保证用户可以看完一条弹幕
        view.y = CGFloat(arc4random() % 10) * view.height 

        view.textLabel.text = "盈盈一水间，脉脉不得语。\(num)"
        view.textLabel.sizeToFit()
        view.width = view.textLabel.width*1.1
        view.x = Screen_Width

        UIView.animate(withDuration:5, delay: 0, options: [.allowUserInteraction,.curveLinear,], animations: {
            view.maxX = 0


        }) { (finish) in
            view.tag = 1

        }
        
        print(allViewArray.count)
        fatherView.addSubview(view)
        
        
    }
    
    func getAvailableFlyLabelView() -> FlyLabelView {
        
        // tag=0 , 说明是马上进行显示,不能复用
        // tag=1 , 说明显示结束,已经移除了屏幕,可以准备下次使用了

        for fly in allViewArray {
            if fly.tag == 1  {
                fly.tag = 0
                return fly
            }
        }
        
        return createNewFlyLableView()
    }
    
    
    func createNewFlyLableView() -> FlyLabelView {
        let view = Bundle.main.loadNibNamed("FlyLabelView", owner: nil, options: nil)?.first as! FlyLabelView
        view.x = Screen_Width
        view.tag = 0
        allViewArray.append(view)
        return view
    }
    
    

}

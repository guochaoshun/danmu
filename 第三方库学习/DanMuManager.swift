
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
    
    // 全部的弹幕
    var allViewArray = [FlyLabelView]()
    // 现在在屏幕上显示的弹幕
    var showViewArray = [FlyLabelView]()
    // 未显示的弹幕
    var hideViewArray = [FlyLabelView]()
  
    
    // 最大的弹幕数量,超出部分会被丢弃,
    var maxDanmuNum = 1000
    
    func showDanMu( text : String , fatherView : UIView = UIApplication.shared.keyWindow! )  {
        
        
        guard let view = getAvailableFlyLabelView() else {
            print("弹幕太多了,后追加的丢弃")
            return
        }
        
        
        // 进行弹道的区分,
        // 有缺陷,弹幕可能会有重叠的情况: 解决方法有以下几种.
        // 应该再有一个方法来获取可用的弹道,把新弹幕优先加入新弹道中;
        /**
         弹幕实在太多的情况,就需要有选择的处理弹幕,
         1.当前登录的用户在自己的屏幕上肯定加入,剩余其他人的弹幕,有选择的加入部分;
         2.在didReceiveMemoryWarning中,可以把不显示的弹幕移除一半,
        还有一个优化建议,比如在某个时刻有很多弹幕, 后续用不到那么多了, 可以动态的去除部分, 比如始终保持hideViewArray.count 小于 showViewArray.count,也可以减少内存消耗
         */
        // 弹幕的速度也要是可变的,短弹幕3秒消失,长弹幕根据字数决定时间
        
        // 方式1 : 在全屏幕上显示弹道,完全随机分布
//        let lineNum = UInt32(Screen_Height / view.height)
//        view.y = CGFloat(arc4random() % lineNum + 1) * view.height
        
        // 方式2 : 优先在上半屏显示弹幕,
        view.tag = getLineNum()
        view.y = CGFloat(view.tag) * view.height

        view.textLabel.text = "\(text)"
        view.textLabel.sizeToFit()
        view.width = view.textLabel.width*1.1
        view.x = Screen_Width
        
        // 动画时间, 短弹幕固定3s,长弹幕根据 字数/3
        var duration = 3.0
        if text.count>10 {
            duration = Double(text.count) / 3
        }
        
        UIView.animate(withDuration:duration, delay: 0, options: [.allowUserInteraction,.curveLinear,], animations: {
            view.maxX = 0


        }) { (finish) in
            view.tag = 1
            if let index = self.showViewArray.index(of: view) {
                self.showViewArray.remove(at: index)
            }
            self.hideViewArray.append(view)
        }
        
        print( "全部的弹幕" + String(allViewArray.count) + "\t\t显示的弹幕" + String(showViewArray.count) +  "\t\t未显示的弹幕" + String(hideViewArray.count))
        fatherView.addSubview(view)
        
    }
    
    /// 去复用池中取出一个可用的弹幕,如果没有就创建一个
    func getAvailableFlyLabelView() -> FlyLabelView? {

        // 如果未显示的数组中有的话,从未显示的取值 , 并把此值移除掉, 加入显示的数组中
        if self.hideViewArray.count > 0 {
            let view = self.hideViewArray.removeLast()
            self.showViewArray.append(view)
            return view
        }
        // 未显示的没有了 , 检查下是否超过了最大数量 , 超过了就不追加了
        if allViewArray.count >= maxDanmuNum {
            return nil
        }
        // 追加一个到数组中
        return createNewFlyLableView()
    }
    
    /// 创建一个新的弹幕
    func createNewFlyLableView() -> FlyLabelView {
        let view = Bundle.main.loadNibNamed("FlyLabelView", owner: nil, options: nil)?.first as! FlyLabelView
        view.x = Screen_Width
        view.tag = 0
        allViewArray.append(view)
        showViewArray.append(view)
        return view
    }
    
    /// 计算弹幕的弹道
    func getLineNum() -> Int {
        let lineNum = Int(Screen_Height / 36.0)
        
        // 随机数的范围
        var rangeLine = lineNum
        // 偏移位置
        var offset = 0
      
        
        var lineArray = [Int]()
        for _ in 0...lineNum {
            lineArray.append(0)
        }
        for view in showViewArray {
            lineArray[view.tag] += 1
        }
        
        // 计算屏幕上半部分的弹幕数量,没超过lineNum*2,就继续显示在上半部分
        var sum = 0
        for i in 0 ..< Int(lineNum/2) {
            sum += lineArray[i]
        }
        if sum<lineNum*2 {
            rangeLine = Int(lineNum/2)
            return getLineWithLineRange(range: rangeLine, offset: offset)

        }
        // 计算屏幕下半部分的弹幕数量
        sum = 0
        for i in Int(lineNum/2) ..< lineNum {
            sum += lineArray[i]
        }
        if sum<lineNum*2 {
            rangeLine = Int(lineNum/2)
            offset = Int(lineNum/2)
            return getLineWithLineRange(range: rangeLine, offset: offset)

        }
        
        // 上下都超过了,说明弹幕真的很多,那就随机分布
        return getLineWithLineRange(range: rangeLine, offset: offset)
        
    }
    /// 根据随机数范围和偏移量,计算出弹道数
    func getLineWithLineRange(range:Int , offset:Int) -> Int {
        var newLine = Int(arc4random() % UInt32(range)) + offset
        if isIphoneX && newLine == 0 {
            newLine += 1
        }
        return newLine
    }
    

}

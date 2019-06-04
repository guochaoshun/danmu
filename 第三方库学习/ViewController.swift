//
//  ViewController.swift
//  第三方库学习
//
//  Created by 郭朝顺 on 2018/7/26星期四.
//  Copyright © 2018年 智网易联. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let manager = DanMuManager.init()
    
    let stringArray = ["哈哈哈哈哈哈哈哈,你是魔鬼吗???",
                       "mdzz",
                       "6",
                       "666",
                       "啦啦啦",
//                       "春天的原野里，你一个人正走着，对面走来了一只可爱的小熊，浑身的毛活像天鹅绒，眼睛圆鼓鼓的。它这么对你说：你好，小姐，和我一块儿打滚玩好吗？接着，你就和小熊一起，顺着长满三叶草的山坡咕噜咕噜滚下去，整整玩了一天。你说棒不棒？",
                       ]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        danMuTest()
        
        
        
        let view = Bundle.main.loadNibNamed("FlyLabelView", owner: nil, options: nil)?.first as! FlyLabelView
        view.centerX  = Screen_Width * 0.5
        view.centerY = Screen_Height * 0.8
        view.tag = 0
        self.view.addSubview(view)
        
    }
    
    
    /**
     想要做的工作:
     1.弹幕遮盖的问题
     2.点击弹幕的事件,比如对弹幕点赞之类的
     3.当手指按住弹幕的时候,能否停止弹幕的动画,使其停在屏幕上
     */
    func danMuTest()  {
        var i = 0
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { (timer) in
            
            self.manager.showDanMu(text: "略略略 "+"\(i)")
            i += 1
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        manager.maxDanmuNum = 100
        
        for _ in 0..<10 {
            let i = Int( arc4random() )%stringArray.count
            manager.showDanMu(text: stringArray[i] , fatherView : self.view)
        }
        
        
        
        
        
    }
    
    
    
    
    

}


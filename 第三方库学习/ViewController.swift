//
//  ViewController.swift
//  第三方库学习
//
//  Created by 郭朝顺 on 2018/7/26星期四.
//  Copyright © 2018年 智网易联. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        danMuTest()
        
    }
    
    
    /**
     想要做的工作:
     1.弹幕遮盖的问题
     2.点击弹幕的事件,比如对弹幕点赞之类的
     3.当手指按住弹幕的时候,能否停止弹幕的动画,使其停在屏幕上
     */
    func danMuTest()  {
        let manager = DanMuManager.init()
        var i = 0
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (timer) in
            
            manager.showDanMu(num: i)
            i += 1
        }
    }
    
    

}


//
//  FlyLabelCell.swift
//  第三方库学习
//
//  Created by 郭朝顺 on 2018/7/26星期四.
//  Copyright © 2018年 智网易联. All rights reserved.
//

import UIKit

class FlyLabelView: UIView {

    @IBOutlet weak var textLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }


    @IBAction func tapFlyLabel(_ tap: UITapGestureRecognizer) {
        
        let point = tap.location(in: self)
        print( point )

        
     
        print("点我干啥?\(textLabel.text ?? "无内容")")
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("点我干啥?\(textLabel.text ?? "无内容")")

    }
    
    /**
    
     - (void)click:(UITapGestureRecognizer *)tap {
     CGPoint touchPoint = [tap locationInView:self];
     for (DTActivityMarqueeView *marqueeView in self.views) {
     if (marqueeView) {
     CALayer *layer = [marqueeView.layer.presentationLayer hitTest:touchPoint];
     if (layer) {
     [marqueeView.delegate activityMarqueeViewClick:marqueeView];
     break;
     }
     }
     }
     }

    */



}

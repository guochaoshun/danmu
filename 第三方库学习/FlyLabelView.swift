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
    
    func tapAction() {
        print("点我干啥?\(textLabel.text ?? "无内容")")

    }

}

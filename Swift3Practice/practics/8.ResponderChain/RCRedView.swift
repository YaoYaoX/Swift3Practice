//
//  RCRedView.swift
//  Swift3Practice
//
//  Created by YaoYaoX on 16/12/29.
//  Copyright © 2016年 YY. All rights reserved.
//

import UIKit

class RCRedView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 打印事件的接收者
        print(String(format: "touched view ^o^ Red:%p\n", self))
    }
    
    // 返回接收事件处理的view
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        // 获取系统调用结果
        let view = super.hitTest(point, with: event)
        
        // 打印系统处理的结果
        if view == nil {
            print(String(format: "red:%p, return:null",self))
        } else {
            let objClass:AnyClass = object_getClass(view)
            print(String(format: "red:%p, return:\(objClass) %p",self , view!))
        }

        return view
    }

    // 触摸点是否在当前view内
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return super.point(inside: point, with: event)
    }
}

//
//  RCGrayView.swift
//  Swift3Practice
//
//  Created by YaoYaoX on 16/12/29.
//  Copyright © 2016年 YY. All rights reserved.
//

import UIKit

class RCGrayView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 打印事件的接收者
        print(String(format: "touched view ^o^ Gray:%p\n", self))
    }
    
    // 返回接收事件处理的view
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        // 系统处理
        // 能处理的条件：userInterectionEnable==true, hidden==false, alpha>0.01, point inside
        // 不处理事件：return nil
        var view = super.hitTest(point, with: event)
        
        // 打印系统处理的结果
        if view == nil {
            print(String(format: "gray:%p, return:null",self))
        } else {
            let objClass:AnyClass = object_getClass(view!)
            print(String(format: "gray:%p, return:\(objClass) %p",self , view!))
        }
        
        // 自定义：若触摸点不在子view上，是自己，则不处理事件
        if view == self {
            // nil则代表不处理事件
            view = nil
        }
        
        return view
    }
    
    // 触摸点是否在当前view内
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return super.point(inside: point, with: event)
    }
}

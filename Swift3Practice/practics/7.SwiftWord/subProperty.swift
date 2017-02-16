//
//  subProperty.swift
//  Swift3Practice
//
//  Created by YaoYaoX on 16/12/27.
//  Copyright © 2016年 YY. All rights reserved.
//

import UIKit

class subProperty: superProperty {
    
    var tempVar:Int = 1
    
    override var storedVar: Int {
//        // 可以重写
//        get {
//            return 10
//        }
//        set {
//            super.storedVar = newValue
//        }
        
        // 可以添加监听器，但与上面不可以同时存在
        didSet {
            print("sub:storedVar:didSet:oldValue:\(oldValue)")
        }
        
        willSet {
            print("sub:storedVar:willSet:newValue:\(newValue)")
        }
    }
    
    override var readOnlyVar: Int{
        // 可以为只读属性添加set，变成读写属性
        get {
            return tempVar
        }
        set {
            tempVar = 30
        }
    }
    
    override var readWriteVar: Int {
        // 读写属性不可以变成只读属性
        get {
            return tempVar
        }
        set {
            tempVar = 50
        }
    }
    override var observerVar: Int{
        // 父类的监听器也会触发
        // 调用顺序：sub.willSet -> super.willSet -> super.didSet -> sub.didSet
        didSet {
            print("sub:observerVar:didSet:oldValue:\(oldValue)")
        }
        
        willSet {
            print("sub:observerVar:willSet:newValue:\(newValue)")
        }
    }
    
    override init() {
        super.init()
        print("\(storedVar)")
    }
 
}

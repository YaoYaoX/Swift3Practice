//
//  superProperty.swift
//  Swift3Practice
//
//  Created by YaoYaoX on 16/12/27.
//  Copyright © 2016年 YY. All rights reserved.
//

import UIKit

class superProperty {
    
    var storedVar = 1
    
    var readOnlyVar: Int {
        return 10
    }
    
    var readWriteVar: Int {
        get {
            return storedVar * 10
        }
        
        set {
            storedVar = newValue/10
        }
    }
    
    var observerVar = 10{
        didSet {
            print("observerVar:didSet:oldValue:\(oldValue)")
        }
        
        willSet {
            print("observerVar:willSet:newValue:\(newValue)")
        }
    }
}

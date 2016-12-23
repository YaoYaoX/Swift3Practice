//
//  ExtensionUIViewController.swift
//  Swift3Practice
//
//  Created by YaoYaoX on 16/12/16.
//  Copyright © 2016年 YY. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    static let swizzle = {
                
                let classType = UIViewController.self
                
                let originSEL = #selector(viewWillAppear(_:))
                let swizzleSEL = #selector(custom_viewWillAppear(_:))
                
                let originMTH = class_getInstanceMethod(classType, originSEL)
                let swizzleMTH = class_getInstanceMethod(classType, swizzleSEL)
                
                let originIMP = class_getMethodImplementation(classType, originSEL)
                let swizzleIMP = class_getMethodImplementation(classType, swizzleSEL)
                
                let didAddMTH = class_addMethod(classType, originSEL, swizzleIMP, method_getTypeEncoding(swizzleMTH))
                if didAddMTH {
                    class_replaceMethod(classType, swizzleSEL, originIMP, method_getTypeEncoding(originMTH))
                } else {
                    method_exchangeImplementations(originMTH, swizzleMTH)
                }
            }
    
    
    
    func custom_viewWillAppear(_ animated: Bool) {
        self.custom_viewWillAppear(animated)
        view.backgroundColor = UIColor.white
    }
}

//
//  ExtensionController.swift
//  Swift3Practice
//
//  Created by YaoYaoX on 17/1/10.
//  Copyright © 2017年 YY. All rights reserved.
//

import UIKit
import NotificationCenter

class ExtensionController: UIViewController {
    
    class var instanceFromStorybord: ExtensionController {
        
        let storyboard = UIStoryboard(name: "ExtensionController", bundle: nil)
        
        if let whpc = storyboard.instantiateInitialViewController() as? ExtensionController {
            return whpc
        }
        
        if let whpc = storyboard.instantiateViewController(withIdentifier: "ExtensionID") as? ExtensionController {
            return whpc
        }
        
        return ExtensionController.init()
    }
    
    var extensionID: String {
        return "com.YY.Swift3Practice.TodayExtension"
    }
    
    var groupID:String {
         return "group.Extension.YY.com"
    }
    
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func hide(_ sender: UIButton) {
        NCWidgetController.widgetController().setHasContent(false, forWidgetWithBundleIdentifier: extensionID)
    }
    
    @IBAction func show(_ sender: UIButton) {
        NCWidgetController.widgetController().setHasContent(true, forWidgetWithBundleIdentifier: extensionID)
    }
    
    @IBAction func writeToUserDefault(_ sender: UIButton) {
        let groupDefault = UserDefaults(suiteName: groupID)
        let randomValue = arc4random_uniform(100)
        groupDefault?.set(randomValue, forKey: "randomvalue")
        groupDefault?.synchronize()
        print("write value \(randomValue) to UserDefault")
    }
    
    @IBAction func readFromUserDefault(_ sender: UIButton) {
        
        let groupDefault = UserDefaults(suiteName: groupID)
        let randomValue = groupDefault?.value(forKey: "randomvalue")
        print("read value \(randomValue ?? "null") from userdefault")
    }
    
    @IBAction func WriteByFileManager(_ sender: UIButton) {
        
        let fm = FileManager.default
        let groupUrl = fm.containerURL(forSecurityApplicationGroupIdentifier: groupID)
        if let fileUrl = groupUrl?.appendingPathComponent("Library/Caches/good") {
            let value =  "group write test \(arc4random_uniform(100))"
            try? value.write(to: fileUrl, atomically: true, encoding: .utf8)
            print("WriteByFileManager:\(value)")
        }
    }
    
    @IBAction func readByFileManager(_ sender: UIButton) {
        
        let fm = FileManager.default
        let groupUrl = fm.containerURL(forSecurityApplicationGroupIdentifier: groupID)
        if let fileUrl = groupUrl?.appendingPathComponent("Library/Caches/good") {
            let value = try? String(contentsOf: fileUrl, encoding: .utf8)
            print("readByFileManager:\(value ?? "null")")
        }
    }
    
}

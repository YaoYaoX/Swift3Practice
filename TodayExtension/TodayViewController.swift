//
//  TodayViewController.swift
//  TodayExtension
//
//  Created by YaoYaoX on 17/1/10.
//  Copyright © 2017年 YY. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    @IBOutlet weak var msglbl: UILabel!
    
    var height = 100
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        height += 20
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        completionHandler(NCUpdateResult.newData)
    }
    
    
    var extensionID: String {
        return "com.YY.Swift3Practice.TodayExtension"
    }
    
    var groupID:String {
        return "group.Extension.YY.com"
    }
    
    @IBAction func open(_ sender: UIButton) {
        
        extensionContext?.open(URL(fileURLWithPath: "extensionScheme://"), completionHandler: { [unowned self](success) in
            self.msglbl.text = "\(success ? "success" : "fail")"
        })
    }
    
    @IBAction func hide(_ sender: UIButton) {
        // 在containing app 中有显示功能
        self.msglbl.text = "show in the containing app"
        NCWidgetController.widgetController().setHasContent(false, forWidgetWithBundleIdentifier: extensionID)
    }
    
    @IBAction func writeToUserDefault(_ sender: UIButton) {
        let groupDefault = UserDefaults(suiteName: groupID)
        let randomValue = arc4random_uniform(100)
        groupDefault?.set(randomValue, forKey: "randomvalue")
        groupDefault?.synchronize()
        msglbl.text = "write value \(randomValue) to UserDefault"
    }
    
    @IBAction func readFromUserDefault(_ sender: UIButton) {
        
        let groupDefault = UserDefaults(suiteName: groupID)
        let randomValue = groupDefault?.value(forKey: "randomvalue")
        msglbl.text = "read value \(randomValue ?? "null") from userdefault"
    }
    
    @IBAction func WriteByFileManager(_ sender: UIButton) {
        
        let fm = FileManager.default
        let groupUrl = fm.containerURL(forSecurityApplicationGroupIdentifier: groupID)
        if let fileUrl = groupUrl?.appendingPathComponent("Library/Caches/good") {
            let value =  "group write test \(arc4random_uniform(100))"
            try? value.write(to: fileUrl, atomically: true, encoding: .utf8)
            msglbl.text = "WriteByFileManager:\(value)"
        }
    }
    
    @IBAction func readByFileManager(_ sender: UIButton) {
        
        let fm = FileManager.default
        let groupUrl = fm.containerURL(forSecurityApplicationGroupIdentifier: groupID)
        if let fileUrl = groupUrl?.appendingPathComponent("Library/Caches/good") {
            let value = try? String(contentsOf: fileUrl, encoding: .utf8)
            msglbl.text = "readByFileManager:\(value)"
        }
    }
}

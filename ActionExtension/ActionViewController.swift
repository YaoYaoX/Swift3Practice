//
//  ActionViewController.swift
//  ActionExtension
//
//  Created by YaoYaoX on 17/1/6.
//  Copyright © 2017年 YY. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {

    @IBOutlet weak var textview: UITextView!

    var pageTitle = ""
    var pageUrl = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // 1. 获取传过来的参数，执行相关操作
        // Get the item[s] we're handling from the extension context.
        if let item = self.extensionContext?.inputItems.first as? NSExtensionItem {
            if let provider = item.attachments?.first as? NSItemProvider {
                if provider.hasItemConformingToTypeIdentifier(kUTTypePropertyList as String) {
                    provider.loadItem(forTypeIdentifier: kUTTypePropertyList as String, options: nil, completionHandler: { [unowned self](dict, error) in
                        print(dict ?? "");
                        let attach = dict as! NSDictionary
                        let data = attach[NSExtensionJavaScriptPreprocessingResultsKey] as! NSDictionary
                        self.pageUrl = data["URL"]! as! String
                        self.pageTitle = data["title"]! as! String
                        
                        DispatchQueue.main.async {
                            self.title = self.pageTitle
                            self.textview.text = self.pageUrl
                        }
                    })
                }
            }
        }
    }

    @IBAction func done() {

        // 2.1 customJS
        let jsDict = ["customJS": self.textview.text!]
        let webDict: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: jsDict]
        let provider = NSItemProvider(item: webDict, typeIdentifier: kUTTypePropertyList as String)
        let item = NSExtensionItem()
        item.attachments = [provider]
        
        // 2.2 退出extension
        self.extensionContext?.completeRequest(returningItems: [item], completionHandler: nil)
    }

}

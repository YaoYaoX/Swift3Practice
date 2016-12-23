//
//  WebviewController.swift
//  Swift3Practice
//
//  Created by YaoYaoX on 16/12/16.
//  Copyright © 2016年 YY. All rights reserved.
//

import UIKit
import WebKit

class WebviewController: UIViewController, WKNavigationDelegate {

    var webview: WKWebView!
    var progressView: UIProgressView!
    
    override func loadView() {
        webview = WKWebView()
        webview.navigationDelegate = self
        webview.allowsBackForwardNavigationGestures = true
        view = webview
        view.backgroundColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(selectWebUrl))
        
        
        progressView = UIProgressView(progressViewStyle: .bar)
        progressView.sizeToFit()
        let progressBtn = UIBarButtonItem(customView: progressView)
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webview, action: #selector(webview.reload))
        self.toolbarItems = [progressBtn, spacer, refresh];
        navigationController?.isToolbarHidden = false
        
        webview.load(URLRequest(url: URL(string:"https://www.baidu.com")!))
        webview.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.isToolbarHidden = true
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webview.estimatedProgress)
            print(String(webview.estimatedProgress))
        }
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webview.title
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        // 决定是否访问该网址 navigationAction.request.url
        // 必须调用，不然crash
        decisionHandler(.allow)
    }
    
    func selectWebUrl() {
        let ac = UIAlertController(title: "open title", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "baidu", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "google", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    func openPage(action: UIAlertAction){
        
        if let title = action.title {
            
            var url = ""
            
            switch title {
                case "baidu":
                    url = "https://www.baidu.com"
                
                case "google":
                    url = "https://www.google.com.hk"
                
                default: break
            }
            
            webview.load(URLRequest(url: URL(string: url)!))
        }
    }
    
    deinit {
        webview.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
    }
}

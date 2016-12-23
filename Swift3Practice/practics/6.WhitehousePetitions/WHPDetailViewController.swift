//
//  WHPDetailViewController.swift
//  Swift3Practice
//
//  Created by YaoYaoX on 16/12/22.
//  Copyright © 2016年 YY. All rights reserved.
//

import UIKit
import WebKit

class WHPDetailViewController: UIViewController {
    
    
    var webView: WKWebView!
    var detailItem: [String: String]!
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard detailItem != nil else {
            return
        }
        
        if let body = detailItem["body"] {
            var html = "<html>"
            html += "<head>"
            html += "<meta name=\"viewport\" content=\"width=device-width,initial-scale=1\">"
            html += "<style> body{font-size: 100%;}</style>"
            html += "</head>"
            html += "<body>"
            html += body
            html += "</body>"
            html += "</html>"
            webView.loadHTMLString(html, baseURL: nil)
        }
        
//        if let body = detailItem["body"] {
//            var html = "<html>"
//            html += "<head>"
//            html += "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">"
//            html += "<style> body { font-size: 150%; } </style>"
//            html += "</head>"
//            html += "<body>"
//            html += body
//            html += "</body>"
//            html += "</html>"
//            webView.loadHTMLString(html, baseURL: nil)
//        }
    }

}

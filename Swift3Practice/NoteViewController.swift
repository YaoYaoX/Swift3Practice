//
//  NoteViewController.swift
//  Swift3Practice
//
//  Created by YaoYaoX on 16/12/13.
//  Copyright © 2016年 YY. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {
    
    var fileName:String?
    var scrollView:UIScrollView?
    var label:UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        let size = view.bounds.size
        
        let scrollV = UIScrollView(frame: view.bounds)
        view.addSubview(scrollV)
        self.scrollView = scrollV
        
        let padding:CGFloat = 12
        let label = UILabel(frame: CGRect(x:padding, y:20, width:(size.width - 2*padding), height: 100))
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        scrollV.addSubview(label)
        self.label = label
        
        loadNote()
    }

    func loadNote() {
        
        let resourcePath = Bundle.main.resourcePath
        if fileName != nil && resourcePath != nil{
            let notePath = resourcePath! + "/" + fileName!
            if let note = try? NSString(contentsOfFile: notePath, encoding: String.Encoding.utf8.rawValue) {
                let noteHeight = note.boundingRect(with: CGSize(width: self.label!.frame.size.width, height: CGFloat(MAXFLOAT)),
                                  options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                  attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 12)],
                                  context: nil).size.height+20
                self.scrollView?.contentSize = CGSize(width:0, height:noteHeight+20);
                self.label?.frame.size.height = noteHeight
                let text = note as String
                self.label!.text = text
            }
        }
        
    }
}

//
//  VFLViewController.swift
//  Swift3Practice
//
//  Created by YaoYaoX on 16/12/21.
//  Copyright © 2016年 YY. All rights reserved.
//

import UIKit

class VFLViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = UIColor.blue
        label1.text = "THIS"
        
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = UIColor.yellow
        label2.text = "IS"
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = UIColor.purple
        label3.text = "A"
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = UIColor.green
        label4.text = "AWESOME"
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = UIColor.cyan
        label5.text = "LABELS"
        
        label1.textAlignment = .center
        label2.textAlignment = .center
        label3.textAlignment = .center
        label4.textAlignment = .center
        label5.textAlignment = .center
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
//        let viewsDictionary = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5]
//        
//        for label in viewsDictionary.keys {
//            let constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewsDictionary)
//            view.addConstraints(constraints)
//        }
//        
//        // ｜：边缘 H：水平方向 V：竖直方向 （value)：值
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(64@999)]-0-[label2(==label1)]-0-[label3(==label1)]-0-[label4(==label1)]-0-[label5(==label1)]", options: [], metrics: nil, views: viewsDictionary))
        
        var preLabel:UILabel?
        
        for label in [label1, label2, label3, label4, label5] {
            label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            label.heightAnchor.constraint(equalToConstant: 64).isActive = true
            
            if preLabel != nil {
                label.topAnchor.constraint(equalTo: preLabel!.bottomAnchor).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: view.topAnchor, constant: 64).isActive = true
            }
            preLabel = label
        }
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
}

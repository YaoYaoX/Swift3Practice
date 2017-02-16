//
//  ResponderChainController.swift
//  Swift3Practice
//
//  Created by YaoYaoX on 16/12/29.
//  Copyright © 2016年 YY. All rights reserved.
//

import UIKit

class ResponderChainController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        let grayView = RCGrayView(frame: view.bounds)
        view.addSubview(grayView)
        
        let bottomY = view.frame.size.height - 30;
        
        let greenV = RCGreenView(frame:CGRect(x:10, y:80, width:70, height:30))
        grayView.addSubview(greenV)
        
        let greenV2 = RCGreenView(frame:CGRect(x:90, y:80, width:70, height:30))
        grayView.addSubview(greenV2)
        
        let greenV3 = RCGreenView(frame:CGRect(x:170, y:80, width:70, height:30))
        grayView.addSubview(greenV3)
        
        let greenV4 = RCGreenView(frame:CGRect(x:250, y:80, width:70, height:30))
        grayView.addSubview(greenV4)
        
        let greenV5 = RCGreenView(frame:CGRect(x:330, y:80, width:70, height:30))
        grayView.addSubview(greenV5)
        
        let greenV6 = RCGreenView(frame:CGRect(x:10, y:bottomY, width:70, height:30))
        grayView.addSubview(greenV6)
        
        let greenV7 = RCGreenView(frame:CGRect(x:90, y:bottomY, width:70, height:30))
        grayView.addSubview(greenV7)
        
        let greenV8 = RCGreenView(frame:CGRect(x:170, y:bottomY, width:70, height:30))
        grayView.addSubview(greenV8)
        
        let greenV9 = RCGreenView(frame:CGRect(x:250, y:bottomY, width:70, height:30))
        grayView.addSubview(greenV9)
        
        let greenV10 = RCGreenView(frame:CGRect(x:330, y:bottomY, width:70, height:30))
        grayView.addSubview(greenV10)
        
        let redV = RCRedView(frame:CGRect(x:10, y:-20, width:30, height:30))
        greenV10.addSubview(redV)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 打印事件的接收者
        print("touched view ^o^ main view\n")
    }
}

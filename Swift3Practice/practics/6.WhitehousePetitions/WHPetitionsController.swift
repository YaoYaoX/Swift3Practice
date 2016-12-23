//
//  WHPetitionsController.swift
//  Swift3Practice
//
//  Created by YaoYaoX on 16/12/22.
//  Copyright © 2016年 YY. All rights reserved.
//

import UIKit

class WHPetitionsController: UITabBarController {
    
    class var instanceFromStorybord: WHPetitionsController {
        
        let storyboard = UIStoryboard(name: "WHPetitionsController", bundle: nil)
        
        if let whpc = storyboard.instantiateViewController(withIdentifier: "WHPTabID") as? WHPetitionsController {
            return whpc
        }
        
        if let whpc = storyboard.instantiateInitialViewController() as? WHPetitionsController {
            return whpc
        }
        return WHPetitionsController.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

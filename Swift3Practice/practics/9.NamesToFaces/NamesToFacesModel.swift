//
//  NamesToFacesModel.swift
//  Swift3Practice
//
//  Created by YaoYaoX on 16/12/30.
//  Copyright © 2016年 YY. All rights reserved.
//

import UIKit

class NamesToFacesModel: NSObject, NSCoding {
    var name: String = "unknown"
    var imageName: String = "test"
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        imageName = aDecoder.decodeObject(forKey: "imageName") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(imageName, forKey: "imageName")
    }
    
}

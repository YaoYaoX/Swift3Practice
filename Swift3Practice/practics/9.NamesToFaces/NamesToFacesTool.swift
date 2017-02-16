//
//  NamesToFacesTool.swift
//  Swift3Practice
//
//  Created by YaoYaoX on 16/12/30.
//  Copyright © 2016年 YY. All rights reserved.
//

import Foundation

class NamesToFacesTool {
    
    class func getImageDirectory() -> String? {
        if let docPath =  NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            let imgDocPath = docPath.appending("/NamesToFacesImages")
            if !FileManager.default.fileExists(atPath: imgDocPath) {
                do {
                    try FileManager.default.createDirectory(at: URL(fileURLWithPath: imgDocPath), withIntermediateDirectories: true, attributes: nil)
                } catch  {
                    return nil
                }
                
            }
            return imgDocPath
        }
        
        return  nil
    }
}


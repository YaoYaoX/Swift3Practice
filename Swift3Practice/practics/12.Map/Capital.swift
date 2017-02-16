//
//  Captical.swift
//  Swift3Practice
//
//  Created by YaoYaoX on 17/2/8.
//  Copyright © 2017年 YY. All rights reserved.
//

import UIKit
import MapKit

class Capital: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var info: String
    var subtitle: String?
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String, subtitle: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
        self.subtitle = subtitle
    }
}

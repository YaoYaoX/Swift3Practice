//
//  PhotoViewerController.swift
//  Swift3Practice
//
//  Created by YaoYaoX on 16/12/8.
//  Copyright © 2016年 YY. All rights reserved.
//

import UIKit

class PhotoViewerController: UITableViewController {
    
    var photos = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        
        typealias typeaaa = PhotoViewerController.Type
        
        let fm = FileManager.default
        let bundlePath = Bundle.main.path(forResource: "PhotoViewer", ofType: "bundle")!
        let files = try! fm.contentsOfDirectory(atPath: bundlePath)
        for file in files {
            if file.hasPrefix("nssl") {
                photos.append(file)
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = photos[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < photos.count {
            let photoName = photos[indexPath.row]
            let imgPath = Bundle.main.path(forResource:"PhotoViewer", ofType:"bundle")!+"/"+photoName;
            let image = UIImage(named: imgPath);
            
            let pvc = PhotoViewController();
            pvc.imgName = photoName
            pvc.image = image
            self.navigationController?.pushViewController(pvc, animated:true)
            
        }
    }
}

//
//  PhotoViewController.swift
//  Swift3Practice
//
//  Created by YaoYaoX on 16/12/12.
//  Copyright © 2016年 YY. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var image:UIImage?
    var imgName:String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = imgName;
        view.backgroundColor = UIColor.black
        setupSubviews();
    }
    
    func setupSubviews() {
        let imgV = UIImageView(frame: view.bounds)
        view.addSubview(imgV)
        imgV.contentMode = UIViewContentMode.scaleAspectFit
        imgV.image = image
        
        let shareItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.action, target: self, action: #selector(action))
        navigationItem.rightBarButtonItem = shareItem
    }
    
    func action() {

       let avc = UIActivityViewController(activityItems: [image!,image!], applicationActivities: [])
        avc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(avc, animated: true, completion: nil)
    }
}

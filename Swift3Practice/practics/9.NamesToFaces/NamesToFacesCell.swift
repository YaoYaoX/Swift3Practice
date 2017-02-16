//
//  NamesToFacesCell.swift
//  Swift3Practice
//
//  Created by YaoYaoX on 16/12/29.
//  Copyright © 2016年 YY. All rights reserved.
//

import UIKit

protocol NamesToFacesCellDelegate {
    func namesToFacesCell(_ cell: NamesToFacesCell, delete model: NamesToFacesModel?)
}

class NamesToFacesCell: UICollectionViewCell {
    

    @IBOutlet weak var photoImgV: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var actionDelegate: NamesToFacesCellDelegate?
    
    
    var model: NamesToFacesModel? {
        didSet{
            var image: UIImage?
            if  model != nil {
                if let path = NamesToFacesTool.getImageDirectory()?.appending("/\(model!.imageName)") {
                    if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                        image = UIImage(data: data)
                    }
                }
            }
            photoImgV.image = image
            nameLbl.text = model?.name
        }
    }
    @IBAction func deleteModel(_ sender: Any) {
        actionDelegate?.namesToFacesCell(self, delete: model)
    }

}

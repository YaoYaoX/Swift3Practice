//
//  CoreImageController.swift
//  Swift3Practice
//
//  Created by YaoYaoX on 17/1/3.
//  Copyright © 2017年 YY. All rights reserved.
//

import UIKit

class CoreImageController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var currentImage: UIImage? {
        didSet {
            imgv.image = currentImage
            imgv.backgroundColor = currentImage == nil ? UIColor(colorLiteralRed: 0.9, green: 0.9, blue: 0.9, alpha: 0.3) : nil
            if currentImage != nil {
                filter.setValue(CIImage(image: currentImage!), forKey: kCIInputImageKey)
            }
        }
    }
    var imgv: UIImageView!
    var filter: CIFilter!
    var context: CIContext!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTools()
        setupSubviews()
    }
    
    func setupTools() {
        filter = CIFilter(name: "CITwirlDistortion")
        context = CIContext()
    }

    func setupSubviews() {
        view.backgroundColor = UIColor.white
        
        // 图片
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.shadowColor = UIColor.lightGray.cgColor
        imageView.layer.shadowRadius = 4
        imageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        imageView.layer.shadowOpacity = 0.5
        view .addSubview(imageView)
        imgv = imageView
        currentImage = nil
        
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(selectPhoto))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGes)
        
        let constraintsH = NSLayoutConstraint.constraints(withVisualFormat: "|-10-[imgv]-10-|", options: [], metrics: nil, views: ["imgv":imageView])
        view.addConstraints(constraintsH)
        
        let constraintsV = NSLayoutConstraint.constraints(withVisualFormat: "V:|-104-[imgv]", options: [], metrics: nil, views: ["imgv":imageView])
        view.addConstraints(constraintsV)
        
        let constraintHeight = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: imageView, attribute: .width, multiplier: 0.8, constant: 0)
        imageView.addConstraint(constraintHeight)
        
        // 参数
        let centerprm = paramaView(title: "center")
        let radiusprm = paramaView(title: "radius")
        let angleprm = paramaView(title: "angle")
        
        centerprm.tag = 100
        radiusprm.tag = 200
        angleprm.tag = 300
        
        view .addSubview(centerprm)
        view.addSubview(radiusprm)
        view.addSubview(angleprm)
        
        let viewDict = ["center":centerprm, "radius":radiusprm, "angle":angleprm]
        let centerH = NSLayoutConstraint.constraints(withVisualFormat: "|-[center]-|", options: [], metrics: nil, views: viewDict)
        let radiusH = NSLayoutConstraint.constraints(withVisualFormat: "|-[radius]-|", options: [], metrics: nil, views: viewDict)
        let angleH = NSLayoutConstraint.constraints(withVisualFormat: "|-[angle]-|", options: [], metrics: nil, views: viewDict)
        let verCons = NSLayoutConstraint.constraints(withVisualFormat: "V:[center(40)]-[radius(40)]-[angle(40)]-70-|", options: [], metrics: nil, views: viewDict)
        
        view.addConstraints(centerH)
        view.addConstraints(radiusH)
        view.addConstraints(angleH)
        view.addConstraints(verCons)
        
        // save 
        let saveBtn = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        navigationItem.rightBarButtonItem = saveBtn
    }
    
    func selectPhoto() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        currentImage = info[UIImagePickerControllerEditedImage] as? UIImage
    }
    
    func save() {
        if let image = imgv.image {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    
    //
    func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: "出错", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "确定", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "已保存", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
            present(ac, animated: true, completion: nil)
        }
    }
    
    func paramaView(title: String) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = title+":"
        view.addSubview(label)
        
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        view.addSubview(slider)
        
        let viewDict = ["label":label, "slider":slider]
        
        let lblConsH = NSLayoutConstraint.constraints(withVisualFormat: "|-[label]", options: [], metrics: nil, views: viewDict)
        let lblConsV = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[label]-|", options: [], metrics: nil, views: viewDict)
        let sliConsH = NSLayoutConstraint.constraints(withVisualFormat: "[label]-15-[slider]-10-|", options: [], metrics: nil, views: viewDict)
        let sliConsV = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[slider]-|", options: [], metrics: nil, views: viewDict)
        view.addConstraints(lblConsH)
        view.addConstraints(lblConsV)
        view.addConstraints(sliConsH)
        view.addConstraints(sliConsV)
        
        return view
    }
    
    func sliderValueChanged(slider: UISlider) {
        
        guard currentImage != nil else {
            return
        }
        
        switch slider.superview!.tag {
            case 100:
                filter.setValue(CIVector(x: currentImage!.size.width / 2, y: currentImage!.size.height / 2), forKey: kCIInputCenterKey)
            
            case 200:
                filter.setValue(slider.value * 200 + 300, forKey: kCIInputRadiusKey)

            case 300:
                filter.setValue(slider.value * Float(M_2_PI * 4) - Float(M_2_PI * 2) , forKey: kCIInputAngleKey)
            
            default:
                break
        }
        
//        print( filter.inputKeys )
//        print( filter.outputKeys )
//        print(filter.attributes)
//        print("\n\n")

        
        progressPhoto()
    }
    
    func progressPhoto() {
        if currentImage != nil {
            let outputImg = filter.outputImage
            if let newImage = context.createCGImage(outputImg!, from: outputImg!.extent) {
                imgv.image = UIImage(cgImage: newImage)
            }
        }
    }

}

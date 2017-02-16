//
//  NamesToFacesController.swift
//  Swift3Practice
//
//  Created by YaoYaoX on 16/12/29.
//  Copyright © 2016年 YY. All rights reserved.
//

import UIKit

class NamesToFacesController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, NamesToFacesCellDelegate{
    
    var datasource = [NamesToFacesModel]()
    var collectionView: UICollectionView!
    
    
    override func loadView() {
        // 布局
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: 150, height: 200)
        flowLayout.minimumLineSpacing = 20
        let spacing = (UIScreen.main.bounds.size.width - 300)/3
        flowLayout.minimumInteritemSpacing = spacing
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: spacing, bottom: 20, right: spacing)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        // 注册nib，不是类，不然加载的不是xib
        collectionView.register(UINib(nibName: "NamesToFacesCell", bundle: nil), forCellWithReuseIdentifier: "NamesToFacesCellID")
        collectionView.delegate = self;
        collectionView.dataSource = self;
        view = collectionView
        self.collectionView = collectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ui
        view.backgroundColor = UIColor.white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add
            , target: self, action: #selector(addPhotoFromLibrary))
        
        // 加载历史数据
        if let listData = UserDefaults.standard.object(forKey: "namesToFacesList") as? Data {
            if let list = NSKeyedUnarchiver.unarchiveObject(with: listData) as? [NamesToFacesModel] {
                datasource.append(contentsOf: list)
                collectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NamesToFacesCellID", for: indexPath) as! NamesToFacesCell
        cell.model = datasource[indexPath.item]
        cell.actionDelegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let image = datasource[indexPath.item]
        
        let ac = UIAlertController(title: "修改名字", message: nil, preferredStyle: .alert)
        ac.addTextField(configurationHandler: nil)
        ac.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        ac.addAction(UIAlertAction(title: "确定", style: .default){ [unowned self, ac] _ in
            image.name = ac.textFields!.first!.text ?? "unknown"
            self.collectionView.reloadData()
            self.refreshLocalData()
        })
        
        present(ac, animated: true, completion: nil)
    }
    
    func addPhotoFromLibrary() {
        let pvc = UIImagePickerController()
        pvc.allowsEditing = true
        pvc.delegate = self
        present(pvc, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let editedImg = info[UIImagePickerControllerEditedImage] as? UIImage else { return }
        
        // 获取唯一标识码
        let imgName = UUID().uuidString
        if let imgPath = NamesToFacesTool.getImageDirectory()?.appending("/\(imgName)") {
            if let imgData = UIImageJPEGRepresentation(editedImg, 100){
                try? imgData.write(to: URL(fileURLWithPath: imgPath))
            }
        }
        
        let newImg = NamesToFacesModel()
        newImg.imageName = imgName
        datasource.append(newImg)
        collectionView.reloadData()
        refreshLocalData()
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    // 更新本地文件
    func refreshLocalData() {
        let data = NSKeyedArchiver.archivedData(withRootObject: datasource)
        UserDefaults.standard.setValue(data, forKey: "namesToFacesList")
    }
    
    // 删除按钮点击
    func namesToFacesCell(_ cell: NamesToFacesCell, delete model: NamesToFacesModel?) {
        if let deleteModel = model {
            if let index = datasource.index(of: deleteModel) {
                datasource.remove(at: index)
                collectionView.reloadData()
                refreshLocalData()
                deleteFiles(modelList: [deleteModel])
            }
        }
    }
    
    // 删文件
    func deleteFiles(modelList: [NamesToFacesModel]?) {
        if let deleteList = modelList {
            if deleteList.count > 0 {
                if let imagePath = NamesToFacesTool.getImageDirectory() {
                    DispatchQueue.global().async {
                        for fileModel in deleteList {
                            try? FileManager.default.removeItem(atPath: imagePath+"/"+fileModel.imageName)
                        }
                    }
                }
            }
        }
    }
}
 

//
//  NoteListController.swift
//  Swift3Practice
//
//  Created by YaoYaoX on 16/12/13.
//  Copyright © 2016年 YY. All rights reserved.
//

import UIKit

class NoteListController: UITableViewController {

    var datasource:[String]? = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Note"
        view.backgroundColor = UIColor.white
        let resourcePath = Bundle.main.resourcePath
        let fm = FileManager.default
        if let files = try? fm.contentsOfDirectory(atPath: resourcePath ?? "") {
            for file in files {
                if file.hasPrefix("Note") {
                    datasource?.append(file)
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "NoteListControllerCell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "NoteListControllerCell")
        }
        cell!.textLabel?.text = datasource?[indexPath.row]
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fileName = datasource?[indexPath.row]
        let noteVC = NoteViewController()
        noteVC.fileName = fileName
        noteVC.title = fileName
        navigationController?.pushViewController(noteVC, animated: true)
    }
}

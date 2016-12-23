//
//  ViewController.swift
//  Swift3Practice
//
//  Created by YaoYaoX on 16/12/8.
//  Copyright © 2016年 YY. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var projects = [[String:String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "main";
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 60;
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        projects.append(["controller":"PhotoViewerController",      "title":"Photo Viewer"])
        projects.append(["controller":"GuessCountryController",     "title":"Guess Country"])
        projects.append(["controller":"WebviewController",          "title":"Webview"])
        projects.append(["controller":"SpellWordController",        "title":"Spell Word"])
        projects.append(["controller":"VFLViewController",          "title":"VFL Test"])
        projects.append(["controller":"WHPetitionsController",      "title":"WhiteHouse Petitions"])
        
        let noteBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
        noteBtn.addTarget(self, action: #selector(notes), for: UIControlEvents.touchUpInside)
        noteBtn.setTitle("note", for: UIControlState.normal)
        noteBtn.setTitleColor(UIColor(red: 10/255.0, green: 96/255.0, blue: 254/255.0, alpha: 1), for: UIControlState.normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: noteBtn)
    }
    
    func notes(){
        let noteList = NoteListController();
        navigationController?.pushViewController(noteList, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count;
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath);
        cell.textLabel?.text = projects[indexPath.row]["title"]
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let title = projects[indexPath.row]["title"]!
        print(title)
        
        if title == "WhiteHouse Petitions" {
            let whpc = WHPetitionsController.instanceFromStorybord
            present(whpc, animated: true, completion: nil)
            return
        }
        
        // 控制器类名
        if let controllerName = projects[indexPath.row]["controller"] {
            // 项目名
            let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
            // 通过“项目名.类名”获取类实例
            let objClass = NSClassFromString(appName+"."+controllerName) as! UIViewController.Type
            // 初始化实例
            let vc = objClass.init();
            // 设置标题
            vc.title = title
            // push
            self.navigationController?.pushViewController(vc, animated: true)
        
        }
  }
}

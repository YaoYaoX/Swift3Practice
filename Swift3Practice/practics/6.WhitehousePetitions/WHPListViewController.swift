//
//  WHPListViewController.swift
//  Swift3Practice
//
//  Created by YaoYaoX on 16/12/22.
//  Copyright © 2016年 YY. All rights reserved.
//

import UIKit

class WHPListViewController: UITableViewController {
    
    var petitions = [[String:String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //loadDataByGCD()
        loadDataByPerformSelector()
    }
    
    func loadDataByGCD() {
        let tag: Int = navigationController?.tabBarItem.tag ?? 0
        DispatchQueue.global().async { [unowned self, tag] in
            
            self.loadListData(tag: tag){ (json) in
                if json != nil {
                    self.parse(json: json!){ (petitionList) in
                        self.petitions.removeAll()
                        self.petitions += petitionList
                        DispatchQueue.main.async {[unowned self] in
                            self.tableView.reloadData()
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showError()
                    }
                }
            }
        }
    }
    
    func loadDataByPerformSelector() {
        performSelector(inBackground: #selector(loadListDataInBackground), with:nil)
    }
    
    func loadListDataInBackground() {
        
        let tag: Int = navigationController?.tabBarItem.tag ?? 0
        loadListData(tag: tag){[weak self] (json: JSON?) -> Void in
            if json != nil {
                self?.parse(json: json!){ (petitionList) in
                    self?.petitions.removeAll()
                    self?.petitions += petitionList
                    self?.tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
                }
            } else {
                self?.performSelector(onMainThread: #selector(WHPListViewController.showError), with: nil, waitUntilDone: false)
            }
        }
    }
    
    func loadListData(tag: Int, complete: (JSON?) -> Void ) {
        
        // url
        var urlString = ""
        if tag == 1 {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
        } else {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        }
        
        // 加载
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                let json = JSON(data:data)
                if json["metadata"]["responseInfo"]["status"].intValue == 200 {
                    complete(json)
                    return;
                }
            }
        }
        
        // 回调
        complete(nil)
    }
    
    
    func parse(json: JSON, complete: ([[String:String]])->Void )  {
        
        var petitions = [[String:String]]()
        for item in json["results"].arrayValue {
            let title = item["title"].stringValue
            let body = item["body"].stringValue
            let sigs = item["signatureCount"].stringValue
            if !body.isEmpty {
                let obj = ["title": title, "body":body, "sign": sigs]
                petitions.append(obj)
            }
        }
        
        complete(petitions)
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }

    @IBAction func dismissAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WHPetitionCell")!
        cell.textLabel?.text = petitions[indexPath.row]["title"]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = WHPDetailViewController()
        detailVC.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

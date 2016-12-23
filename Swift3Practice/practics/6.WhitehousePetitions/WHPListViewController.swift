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
        
        var urlString = ""
        if navigationController?.tabBarItem.tag == 1 {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
        } else {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        }
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                let json = JSON(data:data)
                if json["metadata"]["responseInfo"]["status"].intValue == 200 {
                    parse(json: json)
                    return;
                }
            }
        }
        
        
    }
    
    func parse(json: JSON)  {
        
        petitions.removeAll()
        
        for item in json["results"].arrayValue {
            let title = item["title"].stringValue
            let body = item["body"].stringValue
            let sigs = item["signatureCount"].stringValue
            if !body.isEmpty {
                let obj = ["title": title, "body":body, "sign": sigs]
                petitions.append(obj)
            }
        }
        
        
        tableView.reloadData()
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

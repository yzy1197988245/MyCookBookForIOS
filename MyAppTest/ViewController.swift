//
//  ViewController.swift
//  MyAppTest
//
//  Created by yzy on 16/2/15.
//  Copyright © 2016年 yzy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MyHTTPManagerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var datas = Array<MyCookcate>()
    
    //MARK: table delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let cookcate = self.datas[indexPath.row]
        cell.textLabel?.text = cookcate.name
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let controller:MySecondCookcateViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MySecondCookcateViewController") as! MySecondCookcateViewController
        controller.cookcate = self.datas[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK: http delegate
    func onMyHTTPManagerGETDoing(manager: AnyObject?, progress: NSProgress?) {
        
    }
    
    func onMyHTTPManagerGETDoneWithError(manager: AnyObject?, error: NSError?, task: NSURLSessionDataTask?) {
        print(error)
    }
    
    func onMyHTTPManagerGETDoneWithResult(manager: AnyObject?, result: AnyObject?, task: NSURLSessionDataTask?) {
//        print(result!);
        
        if result != nil {
            let resultDictionary = result as? Dictionary<String, AnyObject>
            let status = resultDictionary?["status"] as? Int
            if status == 1 {
                let results = resultDictionary?["tngou"] as? Array<Dictionary<String, AnyObject>>
                if results != nil {
                    for temp in results! {
                        let myCookcate = MyCookcate(datas: temp)
                        self.datas.append(myCookcate)
                    }
                }
            }
            
            self.tableView.reloadData()
        }
    }
    
    //MARK: view events
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let manager = MyHTTPManager()
        manager.delegate = self;
        
        let headParameter = ["apikey":"b95f5803c158b82035ad5bbbecd5c8f8"]
        
        let parameters = NSMutableDictionary()
        parameters.setObject(0, forKey: "id")
        
        let url = "http://www.tngou.net/api/cook/classify"
        
        manager.GET(url, parameters: parameters, httpHeadParameters: headParameter)
    }
}


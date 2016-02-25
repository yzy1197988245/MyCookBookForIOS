//
//  MyCookBookListViewController.swift
//  MyAppTest
//
//  Created by yzy on 16/2/15.
//  Copyright © 2016年 yzy. All rights reserved.
//

import UIKit

class MyCookBookListViewController: UITableViewController, MyHTTPManagerDelegate {
    
    var cookcate:MyCookcate?
    private var datas = Array<MyCookBook>()
    private var page = 1
    
    func getDatasFromService() -> Void {
        let httpManager = MyHTTPManager()
        httpManager.delegate = self;
        
        let headParameter = ["apikey":"b95f5803c158b82035ad5bbbecd5c8f8"]
        
        let parameters = NSMutableDictionary()
        parameters.setObject((self.cookcate?.id)!, forKey: "id")
        parameters.setObject(self.page, forKey: "page")
        parameters.setObject(20, forKey: "rows")
        
        let url = "http://www.tngou.net/api/cook/list"
        
        httpManager.GET(url, parameters: parameters, httpHeadParameters: headParameter)
    }
    
    func onMyHTTPManagerGETDoneWithResult(manager: AnyObject?, result: AnyObject?, task: NSURLSessionDataTask?) {
//        print(result)
        if result != nil {
            let resultRootDictionary = result as! Dictionary<String, AnyObject>
            let status = resultRootDictionary["status"] as! Int
            if status == 1 {
                let datas = resultRootDictionary["tngou"] as! Array<Dictionary<String, AnyObject>>
                for temp in datas {
                    let myCookBook = MyCookBook(datas: temp)
                    self.datas.append(myCookBook)
                }
            }
        }
        
        self.tableView.reloadData()
        self.page++
    }
    
    func onMyHTTPManagerGETDoneWithError(manager: AnyObject?, error: NSError?, task: NSURLSessionDataTask?) {
        
    }
    
    func onMyHTTPManagerGETDoing(manager: AnyObject?, progress: NSProgress?) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getDatasFromService()
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MyCookBookListItemCell
        cell.setCookBook(self.datas[indexPath.row])
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("MyCookBookDetailViewController") as! MyCookBookDetailViewController
        controller.cookbook = self.datas[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsety = scrollView.contentOffset.y
        let contentSizeY = scrollView.contentSize.height
        let frameY = scrollView.frame.size.height
        let x = offsety + frameY - contentSizeY
        if x > 50 {
            self.getDatasFromService()
        }
    }
}

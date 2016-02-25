//
//  MyFoodListViewController.swift
//  MyAppTest
//
//  Created by yzy on 16/2/16.
//  Copyright © 2016年 yzy. All rights reserved.
//

import UIKit

class MyFoodListViewController: UITableViewController {
    
    var cookbook:MyCookBook?
    private var datas:Array<String>?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.datas = self.cookbook?.food?.componentsSeparatedByString(",")
    }
    
    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.datas!.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = self.datas![indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("MyFoodDetailViewController") as! MyFoodDetailViewController
        
        controller.foodName = self.datas![indexPath.row]
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

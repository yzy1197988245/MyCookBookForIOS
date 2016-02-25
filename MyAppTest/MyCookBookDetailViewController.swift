//
//  MyCookBookDetailViewController.swift
//  MyAppTest
//
//  Created by yzy on 16/2/15.
//  Copyright © 2016年 yzy. All rights reserved.
//

import UIKit

class MyCookBookDetailViewController: UIViewController, MyHTTPManagerDelegate {
    
    var cookbook:MyCookBook?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var keywordsLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var rcountLabel: UILabel!
    @IBOutlet weak var fcountLabel: UILabel!
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var messageWeb: UIWebView!
    @IBOutlet weak var heightOfMessageWeb: NSLayoutConstraint!
    
    @IBAction func barButtonClicked(sender: UIBarButtonItem) {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("MyFoodListViewController") as! MyFoodListViewController
        
        controller.cookbook = self.cookbook
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func getDatasFromService() -> Void {
        let httpManager = MyHTTPManager()
        httpManager.delegate = self;
        
        let headParameter = ["apikey":"b95f5803c158b82035ad5bbbecd5c8f8"]
        
        let parameters = NSMutableDictionary()
        parameters.setValue(self.cookbook?.id, forKey: "id")
        
        let url = "http://www.tngou.net/api/cook/show"
        
        httpManager.GET(url, parameters: parameters, httpHeadParameters: headParameter)
    }
    
    func onMyHTTPManagerGETDoneWithResult(manager: AnyObject?, result: AnyObject?, task: NSURLSessionDataTask?) {
        print(result)
        
        if result != nil {
            let data = result as! Dictionary<String, AnyObject>
            let status = data["status"] as! Int
            if status == 1 {
                self.cookbook = MyCookBook(datas: data)
            }
        }
        
        self.updateView()
    }
    
    func onMyHTTPManagerGETDoneWithError(manager: AnyObject?, error: NSError?, task: NSURLSessionDataTask?) {
        print(error)
    }
    
    func onMyHTTPManagerGETDoing(manager: AnyObject?, progress: NSProgress?) {
        
    }
    
    func updateView() -> Void {
        self.nameLabel.text = self.cookbook?.name
        self.keywordsLabel.text = self.cookbook?.keywords
        self.countLabel.text = "\((self.cookbook?.count)!)"
        self.rcountLabel.text = "\((self.cookbook?.rcount)!)"
        self.fcountLabel.text = "\((self.cookbook?.fcount)!)"
//        self.foodLabel.text = self.cookbook?.food
        self.messageWeb.loadHTMLString((self.cookbook?.message)!, baseURL: nil)
        self.performSelector("updateWebView", withObject: nil, afterDelay: 0.5)
        
        let urlString = "http://tnfs.tngou.net/img\((self.cookbook?.imgUrl)!)"
        self.imageView.setImageWithURL(NSURL(string: urlString)!)
    }
    
    func updateWebView() -> Void {
        UIView.animateWithDuration(0.5) { () -> Void in
            self.heightOfMessageWeb.constant = self.messageWeb.scrollView.contentSize.height
            self.view.layoutIfNeeded()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.getDatasFromService()
        self.messageWeb.scrollView.scrollEnabled = false
    }
}

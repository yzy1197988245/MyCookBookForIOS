//
//  MyHTTPManager.swift
//  MyAppTest
//
//  Created by yzy on 16/2/15.
//  Copyright © 2016年 yzy. All rights reserved.
//

import UIKit

protocol MyHTTPManagerDelegate: NSObjectProtocol {
    func onMyHTTPManagerGETDoing(manager:AnyObject?, progress:NSProgress?) -> Void
    func onMyHTTPManagerGETDoneWithResult(manager:AnyObject?, result:AnyObject?, task:NSURLSessionDataTask?) -> Void
    func onMyHTTPManagerGETDoneWithError(manager:AnyObject?, error:NSError?, task:NSURLSessionDataTask?) -> Void
}

class MyHTTPManager: NSObject {
    
    weak var delegate:MyHTTPManagerDelegate?
    
    private let afManager = AFHTTPSessionManager()
    
    func GET(url:String, parameters:AnyObject?) -> Void {
        self.afManager.GET(url, parameters: parameters,
            progress: { (progress:NSProgress) -> Void in
                self.delegate?.onMyHTTPManagerGETDoing(self, progress: progress)
            },
            success: { (task:NSURLSessionDataTask, result:AnyObject?) -> Void in
                self.delegate?.onMyHTTPManagerGETDoneWithResult(self, result: result, task: task)
            },
            failure: { (task:NSURLSessionDataTask?, error:NSError) -> Void in
                self.delegate?.onMyHTTPManagerGETDoneWithError(self, error: error, task: task)
            }
        )
    }
    
    func GET(url:String, parameters:AnyObject?, httpHeadParameters:Dictionary<String, String>) -> Void {
        for (key,value) in httpHeadParameters {
            self.afManager.requestSerializer.setValue(value, forHTTPHeaderField: key)
        }
        self.GET(url, parameters: parameters)
    }
}

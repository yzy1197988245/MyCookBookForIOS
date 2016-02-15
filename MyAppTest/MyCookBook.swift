//
//  MyCookBook.swift
//  MyAppTest
//
//  Created by yzy on 16/2/15.
//  Copyright © 2016年 yzy. All rights reserved.
//

import UIKit

class MyCookBook: NSObject {
    var id:Int?
    var name:String?
    var food:String?
    var imgUrl:String?
    var images:String?
    var descriptions:String?
    var keywords:String?
    var message:String?
    var count:Int?
    var fcount:Int?
    var rcount:Int?
    
    init(datas:Dictionary<String, AnyObject>) {
        self.count = datas["count"] as? Int
        self.descriptions = datas["description"] as? String
        self.fcount = datas["fcount"] as? Int
        self.food = datas["food"] as? String
        self.id = datas["id"] as? Int
        self.images = datas["images"] as? String
        self.imgUrl = datas["img"] as? String
        self.keywords = datas["keywords"] as? String
        self.name = datas["name"] as? String
        self.rcount = datas["rcount"] as? Int
    }
}

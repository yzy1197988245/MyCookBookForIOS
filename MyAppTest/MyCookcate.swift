//
//  MyCookcate.swift
//  MyAppTest
//
//  Created by yzy on 16/2/15.
//  Copyright © 2016年 yzy. All rights reserved.
//

import UIKit

class MyCookcate: NSObject {
    var cookClass:Int?
    var descriptions:String?
    var id:Int?
    var keyWords:String?
    var name:String?
    var seq:Int?
    var title:String?
    
    init(datas:Dictionary<String, AnyObject>?) {
        self.cookClass = datas?["cookclass"] as? Int
        self.descriptions = datas?["description"] as? String
        self.id = datas?["id"] as? Int
        self.keyWords = datas?["keywords"] as? String
        self.name = datas?["name"] as? String
        self.seq = datas?["seq"] as? Int
        self.title = datas?["title"] as? String
    }
}

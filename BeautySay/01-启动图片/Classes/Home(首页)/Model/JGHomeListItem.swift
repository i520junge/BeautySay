//
//  JGHomeListItem.swift
//  01-启动图片
//
//  Created by 刘军 on 2016/11/6.
//  Copyright © 2016年 JunGe. All rights reserved.
//  数据模型

import UIKit

class JGHomeListItem: NSObject {
    
    var hd_thumb_url: String?
    var thumb_url: String?
    
    
    init(dic: [String: Any]) {
        super.init()
        setValuesForKeys(dic)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}

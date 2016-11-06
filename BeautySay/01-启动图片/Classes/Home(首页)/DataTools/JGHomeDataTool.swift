//
//  JGHomeDataTool.swift
//  01-启动图片
//
//  Created by 刘军 on 2016/11/6.
//  Copyright © 2016年 JunGe. All rights reserved.
//

import UIKit

class JGHomeDataTool: NSObject {

    //方法中多加一个参数，且初始化值，之前调用这个方法的，不会报错，因为参数为非可选的，方法名可不包含，默认会是哪个初始值
    static func getHomeList(page:Int = 1, resultArrBlock:@escaping ([JGHomeListItem],Error?) -> ()){
    
    JGHttpTool.shareInstance.httpRequest(type: .Get, url: KBaseURL, parameters: [
    "opt_type": 1,
    "size" : KPage,
    "offset" : (page - 1) * KPage
    ], resuletBlock: {
    (responseObject:[String : Any]?, error:Error?) -> () in
        
        if error == nil{
        
                //从返回的数据中取出goods_list字典数组，如果没数据，返回一个空模型
                guard let dicArr = responseObject?["goods_list"] as? [[String : Any]] else{
                resultArrBlock([], nil)
                    return
                }
                
                //遍历字典数组，转模型
                var itemArray = [JGHomeListItem]()
                for dic in dicArr{
                    //调用模型中构造方法，字典转模型
                    let homeItem = JGHomeListItem(dic: dic)
                    itemArray.append(homeItem)
                }
                //将转好的模型数组传出去
                resultArrBlock(itemArray, nil)
                }
            
            
        else{
                resultArrBlock([], error)
        }
        
    })
        
    }
    
}

//
//  JGHttpTool.swift
//  01-启动图片
//
//  Created by 刘军 on 2016/11/6.
//  Copyright © 2016年 JunGe. All rights reserved.
//

import UIKit
import AFNetworking

//枚举的名称开头大写
/// 网络请求方式
/// - Get: GET请求
/// - Post: POST请求
enum RequestType {
    case Get
    case Post
}

//    1、创建网络管理者
//    2、发送请求
//    3、返回请求成功或失败的数据
class JGHttpTool: NSObject {

    //提供单例，供外界快速创建对象。static：静态全局，只会分配一次存储空间，修饰属性为类属性
    static let shareInstance = JGHttpTool()

    //对网络管理者进行懒加载处理
//方式一：
//    lazy var manager:AFHTTPSessionManager = {
//        let mgr = AFHTTPSessionManager()
//        return mgr
//    }()
//方式二
//    lazy var manager:AFHTTPSessionManager = {
//        return $0
//    }(AFHTTPSessionManager())
//方式三：
    lazy var manager = AFHTTPSessionManager()
    
    
    /// 发送网络请求，获得响应体
    /// - Parameters:
    ///   - type: 网络请求方式
    ///   - url: 请求的URL
    ///   - parameters: 请求的参数
    ///   - resuletBlock: 请求完成时结果回调
    func httpRequest(type:RequestType ,url:String, parameters:[String:Any] ,resuletBlock:@escaping (_ response:[String:Any]?,_ error:Error?) -> ()){
        
        
        //请求成功闭包
        let successBlock = { (task:URLSessionDataTask,responseObejct:Any?) in
            resuletBlock((responseObejct as? [String : Any]?)!, nil)
        }
        
        //请求失败闭包
        let failureBlock = { (task:URLSessionDataTask?,error: Error) in
            resuletBlock(nil, error)
        }
        
        //判断外界发送的GET还是POST请求
        if type == .Get {       //GET请求
            manager.get(url, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
        }
        else if type == .Post{       //POST请求
            manager.post(url, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
        }
        
    }
    

    
    
}

//
//  Animator.swift
//  图片浏览器
//
//  Created by 刘军 on 2016/11/6.
//  Copyright © 2016年 JunGe. All rights reserved.
//

import UIKit

let animarTime = 0.5

/// 弹出动画代理方法
protocol PresentDelegate: NSObjectProtocol {
    

    // 提供弹出动画的视图
    func presentView() -> UIView
    
    // 弹出视图的起位置
    func presentFromFrame() -> CGRect
    
    // 弹出视图的结束位置
    func presentToFrame() -> CGRect

}

/// 退出视图动画代理方法
protocol DismissDelegate: NSObjectProtocol {
    
    // 提供弹出动画的视图
    func dismissView() -> UIView
    
    // 弹出视图的起位置
    func dismissFromFrame() -> CGRect
    
    // 弹出视图的结束位置
    func dismissToFrame() -> CGRect
    
    
}


class Animator: NSObject, UIViewControllerTransitioningDelegate {

    var isPresented: Bool = true
    
    // 负责从外界, 拿到弹出动画所需要的所有数据
    weak var presentDelegate: PresentDelegate?
    
    weak var dismissDelegate: DismissDelegate?
    
    
    // 弹出动画谁来做
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        return self
    }
    
    // 消失谁来做
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        return self
        
    }
    
    
    
}


// 弹出动画处理
extension Animator: UIViewControllerAnimatedTransitioning {
    
    // 转场动画的时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(animarTime)
    }
    
    
    // 具体的动画怎么做
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        
        if isPresented {
            presentAnimation(transitionContext: transitionContext)
        }else {
            dismissAnimation(transitionContext: transitionContext)
        }
 
    }
    
    
    func dismissAnimation(transitionContext: UIViewControllerContextTransitioning)  {
        
        // 拿到承载视图
        let containerView = transitionContext.containerView
        
        guard let dD = dismissDelegate else {
            return
        }
        
        // 移除目标控制器的视图
        let fromView = transitionContext.view(forKey: .from)
        fromView?.removeFromSuperview()
        
        let animationView = dD.dismissView()
        containerView.addSubview(animationView)
        // 一旦我们自己确定的转场动画, 系统就不会再把, 需要弹出的目标控制器的视图, 添加到承载视图里面, 自己添加
        
        
        
        
        animationView.frame = dD.dismissFromFrame()
        
        
        // 在动画过程当中, 是禁止用户交互的
        
        UIView.animate(withDuration: animarTime, animations: {
            animationView.frame = dD.dismissToFrame()
        }) {
            (flag) -> () in
            
            animationView.removeFromSuperview()
            
            // 告诉系统完成动画, 恢复交互
            transitionContext.completeTransition(true)
            
        }
        
 
        
    }
    
    
    func presentAnimation(transitionContext: UIViewControllerContextTransitioning)  {
        // 拿到承载视图
        let containerView = transitionContext.containerView
        
        guard let pD = presentDelegate else {
            return
        }
        
        
        let animationView = pD.presentView()
        containerView.addSubview(animationView)
        // 一旦我们自己确定的转场动画, 系统就不会再把, 需要弹出的目标控制器的视图, 添加到承载视图里面, 自己添加
        
        
        
        
        animationView.frame = pD.presentFromFrame()
        
        
        // 在动画过程当中, 是禁止用户交互的
        
        UIView.animate(withDuration: animarTime, animations: {
            animationView.frame = pD.presentToFrame()
        }) {
            (flag) -> () in
            
            animationView.removeFromSuperview()
            // 动画完成
            let mubiaoView = transitionContext.view(forKey: .to)
            mubiaoView?.frame = KScreenBounds
            containerView.addSubview(mubiaoView!)
            
            // 告诉系统完成动画, 恢复交互
            transitionContext.completeTransition(true)
            
        }
        
        

    }
    
    
}



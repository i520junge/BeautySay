//
//  JGHomeVC.swift
//  01-启动图片
//
//  Created by 刘军 on 2016/11/5.
//  Copyright © 2016年 JunGe. All rights reserved.
//

import UIKit

//private只能当前类使用，fileprivate当前源文件可使用，如果当前文件有其他类，也是可以使用的
private let homeID = "Cell"




class JGHomeVC: UICollectionViewController {
    weak var detailVC: JGDetailVC?
    
    
    //懒加载动画代理
    lazy var animator: Animator = {
        
        $0.presentDelegate = self
        $0.dismissDelegate = self
        return $0
    }(Animator())
    
    var currentPage = 1
    
    //定义一个模型数组，并初始化
    var itemArrs:[JGHomeListItem] = []{
        didSet{
            self.collectionView?.reloadData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        0、流水布局展示，将collectionview和流布局的初始化操作抽类在流水布局类里面
//        1、发送网络请求：抽网络请求的工具类，防止第三方框架侵入太多控制器
//        2、获取网络请求的数据，并处理：抽数据工具类
        JGHomeDataTool.getHomeList { (itemArrs:[JGHomeListItem], error:Error?) in
            self.itemArrs = itemArrs
        }
        
        //在storyBord中加载cell，不用注册
//        3、展示数据
//        4、加载更多数据
//        5、点击展示详情页
        
    }

}

// MARK:- 数据源
extension JGHomeVC{
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return itemArrs.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: homeID, for: indexPath) as! JGHomeCell
        cell.item = itemArrs[indexPath.row]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
//        print(indexPath.row)
        //当cell跟模型数组一样多数据时，加载下一页
        if indexPath.row == self.itemArrs.count - 1 {
            let loadPage = currentPage + 1
//            print("------加载下一页--------")
            
            JGHomeDataTool.getHomeList(page: loadPage, resultArrBlock: { (items:[JGHomeListItem], error:Error?) in
                //如果请求成功，页码加1，在模型数组后面加上请求下来的数组
                if error == nil{
                    self.currentPage = loadPage
                    self.itemArrs += items
                }else{
                    
                }
            })
        }
    }
    
    //点击cell展示详情
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = JGDetailVC()
        self.detailVC = detailVC
        
        detailVC.row = indexPath.row
        detailVC.detailItemArr = itemArrs
        
        //设置modal动画
        detailVC.modalTransitionStyle = .crossDissolve
        detailVC.modalPresentationStyle = .custom
        detailVC.transitioningDelegate = animator
        
        
        present(detailVC, animated: true, completion: nil)
        
    }
    
    
}

// MARK:- 弹出动画
extension JGHomeVC: PresentDelegate {
    
    // 提供弹出动画的视图
    func presentView() -> UIView {
        
        
        guard let selectIndexPath = collectionView?.indexPathsForSelectedItems?.first else {
            return UIView()
        }
        
        let model = itemArrs[selectIndexPath.row]
        
        let imageView = UIImageView()
        let url = URL(string: model.thumb_url ?? "")
        imageView.sd_setImage(with: url)
        
        
        return imageView
        
    }
    
    // 弹出视图的起位置
    func presentFromFrame() -> CGRect {
        
        guard let selectIndexPath = collectionView?.indexPathsForSelectedItems?.first else {
            return CGRect(x: 0, y: 0, width: 0, height: 0)
        }
        
        guard let cell = collectionView?.cellForItem(at: selectIndexPath) else {
            return CGRect(x: 0, y: 0, width: 0, height: 0)
        }
        
        let window = UIApplication.shared.keyWindow
        let fromFrame = collectionView?.convert(cell.frame, to: window)
        
        return fromFrame!
    }
    
    // 弹出视图的结束位置
    func presentToFrame() -> CGRect {
        
        return KScreenBounds
        
        
    }
    
    
}

// MARK:- 消失动画
extension JGHomeVC: DismissDelegate {
    
    // 提供弹出动画的视图
    func dismissView() -> UIView {
        
        guard let selectIndexPath = self.detailVC?.currentIndexPath else {
            return UIView()
        }
        
        let model = itemArrs[selectIndexPath.row]
        
        let imageView = UIImageView()
        let url = URL(string: model.hd_thumb_url ?? "")
        imageView.sd_setImage(with: url)
        
        
        return imageView
    }
    
    // 弹出视图的起位置
    func dismissFromFrame() -> CGRect {
        return KScreenBounds
    }
    
    // 弹出视图的结束位置
    func dismissToFrame() -> CGRect {
        guard let selectIndexPath = self.detailVC?.currentIndexPath else {
            return CGRect(x: 0, y: 0, width: 0, height: 0)
        }
        
        guard let cell = collectionView?.cellForItem(at: selectIndexPath) else {
            
            
            var visibleIndexPathes = collectionView?.indexPathsForVisibleItems
            
            visibleIndexPathes?.sort(by: { (indexPath1, indexPath2) -> Bool in
                return indexPath1.row < indexPath2.row
            })
            
            
            if selectIndexPath.row < visibleIndexPathes?.first?.row ?? 0 {
                
                return CGRect(x: 0, y: 0, width: 0, height: 0)
                
            }
            
            if selectIndexPath.row > visibleIndexPathes?.last?.row ?? 0
            {
                
                return CGRect(x: KScreenW, y: KScreenH, width: 0, height: 0)
            }
            
            return CGRect(x: 0, y: 0, width: 0, height: 0)
            
        }
        
        let window = UIApplication.shared.keyWindow
        let fromFrame = collectionView?.convert(cell.frame, to: window)
        
        return fromFrame!
    }
    
}

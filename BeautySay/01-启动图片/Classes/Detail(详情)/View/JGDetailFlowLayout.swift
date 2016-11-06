//
//  JGDetailFlowLayout.swift
//  01-启动图片
//
//  Created by 刘军 on 2016/11/6.
//  Copyright © 2016年 JunGe. All rights reserved.
//

import UIKit

class JGDetailFlowLayout: UICollectionViewFlowLayout {

    override func prepare() {
        let margin:CGFloat = 10
        //设置cell的宽高
        itemSize = CGSize(width: KScreenW, height: KScreenH)
        //水平滑动
        scrollDirection = .horizontal
        minimumLineSpacing = margin
        minimumInteritemSpacing = 0
        collectionView?.isPagingEnabled = true
    }
    
}

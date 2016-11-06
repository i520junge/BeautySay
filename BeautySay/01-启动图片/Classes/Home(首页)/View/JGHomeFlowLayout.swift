//
//  JGHomeFlowLayout.swift
//  01-启动图片
//
//  Created by 刘军 on 2016/11/6.
//  Copyright © 2016年 JunGe. All rights reserved.
//

import UIKit

class JGHomeFlowLayout: UICollectionViewFlowLayout {

    //重写prepare方法
    override func prepare() {
        let col:CGFloat = 3
        let margin:CGFloat = 10
        let itemW = (KScreenW - (col + 1)*margin)/col
        //设置cell的宽高
        itemSize = CGSize(width: itemW, height: itemW * 1.3)
        minimumLineSpacing = margin //注意，分页是按照UICollectionView分页的，故设置好xib右边内边距为-10，否则累加出问题
        minimumInteritemSpacing = 0
        collectionView?.contentInset = UIEdgeInsetsMake(20, margin, margin, margin)
        collectionView?.backgroundColor = UIColor.gray
    }
    
}

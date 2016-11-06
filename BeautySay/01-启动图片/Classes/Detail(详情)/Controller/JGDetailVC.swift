//
//  JGDetailVC.swift
//  01-启动图片
//
//  Created by 刘军 on 2016/11/6.
//  Copyright © 2016年 JunGe. All rights reserved.
//

import UIKit

private let detailID = "detailCell"

class JGDetailVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var detailItemArr:[JGHomeListItem]?
    
    /// 记录点击了第几个
    var row = 0
    
    var currentIndexPath: IndexPath {
        get {
            // 错误
            return (collectionView.indexPathsForVisibleItems.first)!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "JGDetailCell", bundle: nil), forCellWithReuseIdentifier: detailID)
        
        self.collectionView.reloadData()
        
    }
    
    //布局好时，让cell展示点击的那张图片
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let indexPath = IndexPath(item: row, section: 0)
        collectionView.scrollToItem(at: indexPath, at:.left, animated: false)
    }
    
    
    @IBAction func dismissClick(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}



    extension JGDetailVC: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (self.detailItemArr?.count)!
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailID, for: indexPath) as! JGDetailCell
        cell.item = detailItemArr?[indexPath.row]
        
        return cell
    }
    
        
}

    
    


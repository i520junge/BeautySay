//
//  JGHomeCell.swift
//  01-启动图片
//
//  Created by 刘军 on 2016/11/6.
//  Copyright © 2016年 JunGe. All rights reserved.
//

import UIKit
import SDWebImage

class JGHomeCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    var item:JGHomeListItem? {
        didSet{
            guard let url = URL(string:item?.thumb_url ?? "") else {
                return
            }
            
            imageView.sd_setImage(with: url, placeholderImage: UIImage.init(named: "jg"))
        }
    }
}

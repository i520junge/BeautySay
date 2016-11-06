//
//  JGDetailCell.swift
//  01-启动图片
//
//  Created by 刘军 on 2016/11/6.
//  Copyright © 2016年 JunGe. All rights reserved.
//

import UIKit
import SDWebImage

class JGDetailCell: UICollectionViewCell {
    @IBOutlet weak var detailImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var item:JGHomeListItem? {
        didSet{
            guard let url = URL(string:item?.hd_thumb_url ?? "") else {
                return
            }
            
            detailImageView.sd_setImage(with: url, placeholderImage: nil)
        }
    }
    

}

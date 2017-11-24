//
//  ZYChannelView.swift
//  GiveGiftAnimation
//
//  Created by 王志盼 on 2017/11/23.
//  Copyright © 2017年 王志盼. All rights reserved.
//

import UIKit

class ZYChannelView: UIView {

    // MARK: 控件属性
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var senderLabel: UILabel!
    @IBOutlet weak var giftDescLabel: UILabel!
    @IBOutlet weak var giftImageView: UIImageView!
    @IBOutlet weak var digitLabel: ZYGiftNumLabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

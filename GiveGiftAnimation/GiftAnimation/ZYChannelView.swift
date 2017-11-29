//
//  ZYChannelView.swift
//  GiveGiftAnimation
//
//  Created by 王志盼 on 2017/11/23.
//  Copyright © 2017年 王志盼. All rights reserved.
//

import UIKit

enum ZYChannelViewAnimationType {
    case idle       //闲置
    case animating      //正在执行动画
    case willEnd        //将要结束动画(在移动动画结束，正在悬浮3s的时候)
    case endAnimating   //结束动画（悬浮3s结束，开始执行结束动画）
}

class ZYChannelView: UIView {

    //动画执行状态
    var status: ZYChannelViewAnimationType = .idle
    
    //当前的礼物数目
    var currentNum: Int = 0
    
    //还需要执行礼物动画的次数
    var cacheNum: Int = 0
    
    var finishedCallBackBlock: ((ZYChannelView)->Void)?
    
    var giftEntity: ZYGiveGiftEntity? {
        didSet{
            guard let entity = giftEntity else {return}
            
            iconImageView.image = UIImage(named: entity.senderURL)
            senderLabel.text = entity.senderName
            giftDescLabel.text = "送出礼物：【\(entity.giftName)】"
            giftImageView.image = UIImage(named: entity.giftURL)
            
            showAnimation()
        }
    }
    
    
    
    // MARK: 控件属性
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var senderLabel: UILabel!
    @IBOutlet weak var giftDescLabel: UILabel!
    @IBOutlet weak var giftImageView: UIImageView!
    @IBOutlet weak var numLabel: ZYGiftNumLabel!
    
    class func loadFromXib() ->ZYChannelView {
        return (Bundle.main.loadNibNamed("ZYChannelView", owner: nil, options: nil)?.first) as! ZYChannelView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bgView.layer.cornerRadius = frame.height * 0.5
        iconImageView.layer.cornerRadius = frame.height * 0.5
        bgView.layer.masksToBounds = true
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.borderWidth = 1
        iconImageView.layer.borderColor = UIColor.green.cgColor
    }
}


// MARK: - 连击逻辑
extension ZYChannelView {
    func addOneToCache() {
        if status == .willEnd {
            showNumLabelAnimation()
            NSObject.cancelPreviousPerformRequests(withTarget: self)
        }
        else {
            cacheNum += 1
        }
    }
}

// MARK: - 动画
extension ZYChannelView {
    fileprivate func showAnimation() {
        status = .animating
        numLabel.text = "  X1  "
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 1
            self.frame.origin.x = 0
        }) { (isFinished) in
            self.showNumLabelAnimation()
        }
    }
    
    fileprivate func showNumLabelAnimation() {
        currentNum += 1
        numLabel.text = "  X\(currentNum)  "
        numLabel.showNumAnimation {[weak self] in
            guard let cacheNum = self?.cacheNum else {return}
            if cacheNum > 0 {
                self?.cacheNum -= 1
                self?.showNumLabelAnimation()
            }
            else {
                self?.status = .willEnd
                self?.perform(#selector(self?.showEndAnimation), with: nil, afterDelay: 3)
            }
        }
    }
    
    @objc fileprivate func showEndAnimation() {
        status = .endAnimating
        
        UIView.animate(withDuration: 0.25, animations: {
            self.frame.origin.x = UIScreen.main.bounds.width
            self.alpha = 0
        }) { (isFinished) in
            self.status = .idle
            self.currentNum = 0
            self.cacheNum = 0
            self.giftEntity = nil
            self.frame.origin.x = -self.frame.width
            
            guard let finishedBlock = self.finishedCallBackBlock else {return}
            finishedBlock(self)
        }
    }
}

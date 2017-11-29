//
//  ZYContainView.swift
//  GiveGiftAnimation
//
//  Created by 王志盼 on 2017/11/29.
//  Copyright © 2017年 王志盼. All rights reserved.
//

import UIKit

private let kChannelViewCount = 2
private let kChannelViewH: CGFloat = 50
private let kChannelViewMargin: CGFloat = 10

class ZYContainView: UIView {

    fileprivate lazy var channelViewArr: [ZYChannelView] = [ZYChannelView]()
    
    fileprivate lazy var entityCacheArr: [ZYGiveGiftEntity] = [ZYGiveGiftEntity]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ZYContainView {
    fileprivate func setupUI() {
        let x: CGFloat = 0
        var y: CGFloat = kChannelViewMargin
        let width: CGFloat = self.bounds.width
        
        for _ in 0..<kChannelViewCount {
            let channelView = ZYChannelView.loadFromXib()
            channelView.frame = CGRect(x: x, y: y, width: width, height: kChannelViewH)
            y += kChannelViewH + kChannelViewMargin
            
            addSubview(channelView)
            channelViewArr.append(channelView)
            
            //完成动画的回调
            channelView.finishedCallBackBlock = {[weak self] channelView in
                //需要判断缓存里面是否还有模型，如果有模型，闲置下来的channelView需要再次播放
                guard let entity = self?.entityCacheArr.first else {return}
                
                self?.entityCacheArr.removeFirst()
                channelView.giftEntity = entity
                
                //遍历缓存数组，判断是否有和选中的entity相同的模型
                for i in (0..<(self?.entityCacheArr.count ?? 0)).reversed() {
                    let tmpEntity = self?.entityCacheArr[i]
                    if entity.isEqual(tmpEntity) {
                        channelView.addOneToCache()
                        self?.entityCacheArr.remove(at: i)
                    }
                }
            }
        }
    }
}

extension ZYContainView {
    func showGiftEntity(entity: ZYGiveGiftEntity) {
        //对于一个新加入的entity，首先判断是否存在与它一样的正在展示的channelView
        //其次判断是否有闲置的channelView
        //最后才是放到缓存中准备被展示
        
        if let channelView = checkUsingChannelView(entity) {
            channelView.addOneToCache()
            return
        }
        
        /*
         有这样一个问题，这里为什么可以直接寻找idle状态的channelView，而不是直接加入entityCacheArr？
         因为在channelView的finishedCallBackBlock进行了处理
         1、当channelView执行完动画刚被置为idel状态的时候，第一时间是会去检查entityCacheArr是否还有entity
         2、如果有，channelView就直接继续进行动画了，那么此刻这里就拿不到idel状态下的channelView
         3、如果没有，这个时候这里才会拿到idel状态的channelView
         */
        if let channelView = findIdleStatusChannelView() {
            channelView.giftEntity = entity
            return
        }
        
        entityCacheArr.append(entity)
        
    }
    
    fileprivate func checkUsingChannelView(_ entity: ZYGiveGiftEntity) ->ZYChannelView? {
        for channelView in channelViewArr {
            if channelView.status != .idle && (channelView.giftEntity?.isEqual(entity))! {
                return channelView
            }
        }
        return nil
    }
    
    fileprivate func findIdleStatusChannelView() ->ZYChannelView? {
        
        for channelView in channelViewArr {
            if channelView.status == .idle {
                return channelView
            }
        }
        
        return nil
    }
}

//
//  ViewController.swift
//  GiveGiftAnimation
//
//  Created by 王志盼 on 2017/11/23.
//  Copyright © 2017年 王志盼. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    fileprivate lazy var giftContainerView : ZYContainView = ZYContainView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 300))
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        giftContainerView.backgroundColor = UIColor.green
        view.addSubview(giftContainerView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func clickGiftOneBtn(_ sender: Any) {
        let gift1 = ZYGiveGiftEntity(senderName: "coderwhy", senderURL: "icon4", giftName: "火箭", giftURL: "prop_b")
        giftContainerView.showGiftEntity(entity: gift1)
    }
    
    @IBAction func clickGiftTwoBtn(_ sender: Any) {
        let gift2 = ZYGiveGiftEntity(senderName: "coder", senderURL: "icon2", giftName: "飞机", giftURL: "prop_f")
        giftContainerView.showGiftEntity(entity: gift2)
    }
    
    @IBAction func clickGiftThreeBtn(_ sender: Any) {
        let gift3 = ZYGiveGiftEntity(senderName: "why", senderURL: "icon3", giftName: "跑车", giftURL: "prop_g")
        giftContainerView.showGiftEntity(entity: gift3)
    }
    
}



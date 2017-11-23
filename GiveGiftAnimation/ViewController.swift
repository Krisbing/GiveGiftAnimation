//
//  ViewController.swift
//  GiveGiftAnimation
//
//  Created by 王志盼 on 2017/11/23.
//  Copyright © 2017年 王志盼. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var giftLabel: ZYGiftNumLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        giftLabel.showNumAnimation {
            print("动画结束")
        }
    }
    

}


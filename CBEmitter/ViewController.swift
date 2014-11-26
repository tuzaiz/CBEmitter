//
//  ViewController.swift
//  CBEmitter
//
//  Created by Henry on 2014/11/26.
//  Copyright (c) 2014年 Cloudbar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var emitter = CBEmitter()
        var listener = emitter.on("trigger", emit: { (userInfo) -> Void in
            println("Trigger: \(userInfo)")
        })
        
        emitter.emit("trigger", userInfo: ["data": "1"])
        CBEmitter.emit("trigger", userInfo: ["data": "2"])

        emitter.off(listener)
        emitter.emit("trigger", userInfo: ["data": "3"])
        
        emitter.off(listener)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


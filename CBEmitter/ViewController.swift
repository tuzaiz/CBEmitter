//
//  ViewController.swift
//  CBEmitter
//
//  Created by Henry on 2014/11/26.
//  Copyright (c) 2014年 Cloudbay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var emitter = CBEmitter.defaultEmitter()

        var listener = emitter.on("triggerKey") {data in
            println("Event triggered with data: \(data)")
        }
        
        emitter.emit("triggerKey", data: ["data": "1"])
        CBEmitter.emitToAllEmitters("triggerKey", data: ["data":"2"])

        emitter.off(listener)
        emitter.emit("triggerKey", data: ["data": "3"])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}


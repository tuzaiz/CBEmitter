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
            println("[1] Event triggered with data: \(data)")
        }
        
        emitter.once("triggerKey").then { (data) -> Void in
            println("[2] Event triggered with data: \(data)")
        }
        
        emitter.on("triggerKey2").then { (data) -> Void in
            println("[3] Event triggered with data: \(data)")
        }
        
        emitter.emit("triggerKey", data: ["data": "1"])
        CBEmitter.emitToAllEmitters("triggerKey", data: ["data":"2"])

        emitter.off(listener)
        emitter.emit("triggerKey", data: ["data": "3"])
        
        emitter.emit("triggerKey2", data: ["data": "4"])
        emitter.off("triggerKey2")
        emitter.emit("triggerKey2", data: ["data": "5"])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}


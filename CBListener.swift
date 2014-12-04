//
//  CBListener.swift
//  CBEmitter
//
//  Created by Henry on 2014/11/26.
//  Copyright (c) 2014年 Cloudbay. All rights reserved.
//

import UIKit

class CBListener : NSObject {
    var callback : (Dictionary<NSObject, AnyObject>?) -> Void
    var key : String
    var once : Bool
    var emitter : CBEmitter?
    
    init(key:String, once:Bool, callback:(Dictionary<NSObject, AnyObject>?)->Void) {
        self.key = key
        self.callback = callback
        self.once = once
        super.init()
        
    }
    
    func eventDidTrigger(notification : NSNotification) {
        self.fire(notification.userInfo)
    }
    
    func fire(userInfo : [NSObject : AnyObject]?) {
        self.callback(userInfo)
        if self.once {
            if let emitter = self.emitter
            {
                emitter.removeListener(self)
            }
        }
    }
}
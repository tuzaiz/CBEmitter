//
//  CBListener.swift
//  CBEmitter
//
//  Created by Henry on 2014/11/26.
//  Copyright (c) 2014年 Cloudbay. All rights reserved.
//

import Foundation

class CBListener : NSObject {
    var callback : (([NSObject: AnyObject]?) -> Void)?
    var key : String
    var once : Bool
    var emitter : CBEmitter?
    
    init(key:String, once:Bool, callback:(([NSObject:AnyObject]?)->Void)?) {
        self.key = key
        self.callback = callback
        self.once = once
        super.init()
    }
    
    convenience init(key:String, once:Bool) {
        self.init(key: key, once:once, callback:nil)
    }
    
    func eventDidTrigger(notification : NSNotification) {
        self.fire(notification.userInfo)
    }
    
    func fire(userInfo : [NSObject : AnyObject]?) {
        if let callback = self.callback {
            callback(userInfo)
        }
        if self.once {
            if let emitter = self.emitter
            {
                emitter.removeListener(self)
            }
        }
    }
    
    internal func then(callback:([NSObject:AnyObject]?)->Void) {
        self.callback = callback
    }
}
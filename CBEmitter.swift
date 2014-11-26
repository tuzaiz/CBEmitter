//
//  CBEmitter.swift
//  CBEmitter
//
//  Created by Henry on 2014/11/26.
//  Copyright (c) 2014年 Cloudbar. All rights reserved.
//

import UIKit

let emitterPrefixKey = "Emitter"

class CBEmitter: NSObject {
    
    private var listeners : Dictionary<String, [CBListener]> = Dictionary()
    
    internal func on(key:String, emit:([NSObject : AnyObject]?) -> Void) -> CBListener {
        var listeners = self.listeners[key]
        var listener = CBListener(key: key, once: false, callback: emit)
        listener.emitter = self
        if listeners != nil {
            listeners?.append(listener)
            self.listeners[key] = listeners
        } else {
            listeners = [listener]
            self.listeners[key] = listeners
        }
        return listener
    }
    
    internal func off(listener:CBListener) {
        listener.stopListening()
        self.removeListener(listener)
    }
    
    internal func once(key:String, emit:([NSObject : AnyObject]?) -> Void) -> CBListener {
        var listeners = self.listeners[key]
        var listener = CBListener(key: key, once: true, callback: emit)
        listener.emitter = self
        if listeners != nil {
            listeners?.append(listener)
            self.listeners[key] = listeners
        } else {
            listeners = [listener]
            self.listeners[key] = listeners
        }
        return listener
    }
    
    internal func removeListener(listener:CBListener) {
        var listeners = self.listeners[listener.key]
        if listeners != nil {
            for (index, listen) in enumerate(listeners!) {
                if listen == listener {
                    listeners?.removeAtIndex(index)
                }
            }
            self.listeners[listener.key] = listeners
        }
    }
    
    func emit(key:String, userInfo:Dictionary<NSObject, AnyObject>?) {
        if var listeners = self.listeners[key] {
            for listener in listeners {
                listener.fire(userInfo)
            }
        }
    }
    
    class func emit(key:String, userInfo:Dictionary<NSObject, AnyObject>?) {
        NSNotificationCenter.defaultCenter().postNotificationName("\(emitterPrefixKey)_\(key)", object: nil, userInfo: userInfo)
    }
}

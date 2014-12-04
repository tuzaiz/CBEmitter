//
//  CBEmitter.swift
//  CBEmitter
//
//  Created by Henry on 2014/11/26.
//  Copyright (c) 2014年 Cloudbay. All rights reserved.
//

import UIKit

let EmitterGlobalNotificationKey = "EmitterGlobalNotificationKey"

class CBEmitter: NSObject {
    
    private var listeners : Dictionary<String, [CBListener]> = Dictionary()
    
    override init() {
        super.init()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "globalEmitterDidEmit:", name: EmitterGlobalNotificationKey, object: nil)
    }
    
    class func defaultEmitter() -> CBEmitter {
        struct Shared {
            static let instance = CBEmitter()
        }
        return Shared.instance
    }
    
    internal func on(key:String, callback:([NSObject : AnyObject]?) -> Void) -> CBListener {
        var listeners = self.listeners[key]
        var listener = CBListener(key: key, once: false, callback: callback)
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
        self.removeListener(listener)
    }
    
    internal func once(key:String, callback:([NSObject : AnyObject]?) -> Void) -> CBListener {
        var listeners = self.listeners[key]
        var listener = CBListener(key: key, once: true, callback: callback)
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
    
    internal func addListener(listener:CBListener) {
        if var listeners = self.listeners[listener.key] {
            listeners.append(listener)
            self.listeners[listener.key] = listeners
        } else {
            var listeners = [listener]
            self.listeners[listener.key] = listeners
        }
    }
    
    internal func emit(key:String, userInfo:Dictionary<NSObject, AnyObject>?) {
        if var listeners = self.listeners[key] {
            for listener in listeners {
                listener.fire(userInfo)
            }
        }
    }
    
    private func globalEmitterDidEmit(notification : NSNotification) {
        if let dict = notification.userInfo as? [String : AnyObject] {
            let key = dict["key"] as String
            let data = dict["data"] as [NSObject : AnyObject]
            self.emit(key, userInfo: data)
        }
    }
    
    class func emitToAllEmitters(key:String, data:Dictionary<NSObject, AnyObject>?) {
        var userInfo : [String : AnyObject]
        if let d = data {
            userInfo = [
                "key": key,
                "data": d
            ]
        } else {
            userInfo = [
                "key": key
            ]
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName(EmitterGlobalNotificationKey, object: nil, userInfo: userInfo)
    }
}

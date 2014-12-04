//
//  CBEmitter.swift
//  CBEmitter
//
//  Created by Henry on 2014/11/26.
//  Copyright (c) 2014年 Cloudbay. All rights reserved.
//

import Foundation

let EmitterGlobalNotificationKey = "EmitterGlobalNotificationKey"

class CBEmitter: NSObject {
    
    private var listeners : [String : [CBListener]] = Dictionary()
    
    override init() {
        super.init()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "globalEmitterDidEmit:", name: EmitterGlobalNotificationKey, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    class func defaultEmitter() -> CBEmitter {
        struct Shared {
            static let instance = CBEmitter()
        }
        return Shared.instance
    }
    
    internal func on(key:String, callback:([NSObject : AnyObject]?) -> Void) -> CBListener {
        var listener = CBListener(key: key, once: false, callback: callback)
        listener.emitter = self
        if var listeners = self.listeners[key] {
            listeners.append(listener)
            self.listeners[key] = listeners
        } else {
            self.listeners[key] = [listener]
        }
        return listener
    }
    
    internal func off(listener:CBListener) {
        self.removeListener(listener)
    }
    
    internal func once(key:String, callback:([NSObject : AnyObject]?) -> Void) -> CBListener {
        var listener = CBListener(key: key, once: true, callback: callback)
        listener.emitter = self
        if var listeners = self.listeners[key] {
            listeners.append(listener)
            self.listeners[key] = listeners
        } else {
            self.listeners[key] = [listener]
        }
        return listener
    }
    
    internal func removeListener(listener:CBListener) {
        if var listeners = self.listeners[listener.key] {
            for (index, listen) in enumerate(listeners) {
                if listen == listener {
                    listeners.removeAtIndex(index)
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
    
    internal func emit(key:String, data:[NSObject: AnyObject]?) {
        if var listeners = self.listeners[key] {
            for listener in listeners {
                listener.fire(data)
            }
        }
    }
    
    dynamic private func globalEmitterDidEmit(notification : NSNotification) {
        if let dict = notification.userInfo as? [String : AnyObject] {
            let key = dict["key"] as String
            let data = dict["data"] as [NSObject : AnyObject]
            self.emit(key, data: data)
        }
    }
    
    class func emitToAllEmitters(key:String, data:[NSObject: AnyObject]?) {
        var userInfo : [String : AnyObject] = ["key": key]
        if let d = data {
            userInfo.updateValue(d, forKey: "data")
        }
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.postNotificationName(EmitterGlobalNotificationKey, object: nil, userInfo: userInfo)
    }
}

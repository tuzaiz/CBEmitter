CBEmitter
=========

An event driven library like eventEmitter in Swift.

# How to use

Copy the two files `CBEmitter.swift` and `CBListener.swift` to your project.

# Sample

```
var emitter = CBEmitter()
emitter.on("notificationKey") {(userInfo) in
  println("Do something")
}
emitter.emit("notificationKey", data: nil)
```

# Create emitter

Every emitter are independent of others, and can pass the emitter from instance to instance.

```
var emitter = CBEmitter()
```

# Start observer

```
emitter.on("listenKey") { data in
  // Here is the code when emit.
}

OR

emitter.on("listenKey").then { data in
  // Here is the code when emit.
}
```

# Stop observer

```
emitter.off("listenKey")
```

# Observer once

```
emitter.once("listenKey") { data in
  // Here will run only once.
}
```

# Trigger emitter

```
emitter.emit("listenKey", data: ["dataKey":"dataValue"])
```

# Emit to all emitters

```
CBEmitter.emitToAllEmitters("listenKey", data: ["dataKey":"dataValue"])
```

# TODO

* Use `key.*` and more selector to match listeners.
* Add some promise style functions. 
* Add callback when listener did finish, off.

# License

ConciseCore is released under an MIT license. 

Copyright (C) <2014> <rabbit.henry@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

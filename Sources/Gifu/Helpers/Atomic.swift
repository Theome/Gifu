//
//  Atomic.swift
//  Gifu
//
//  Created by Theodor Müller on 06.05.21.
//

import Foundation

@propertyWrapper
struct Atomic<Value> {
    private var value: Value
    private var lock = NSLock()

    var wrappedValue: Value {
        get { lock.synchronized { value } }
        set { lock.synchronized { value = newValue } }
    }

    init(wrappedValue value: Value) {
        self.value = value
    }
}

extension NSLocking {
    func synchronized<T>(block: () throws -> T) rethrows -> T {
        lock()
        defer { unlock() }
        return try block()
    }
}

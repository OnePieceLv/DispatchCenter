//
//  SpinLock.swift
//  DispatchCenter
//
//  Created by steven on 2021/2/17.
//

import Foundation

final class SpinLock {
    
    private let lock: NSRecursiveLock = NSRecursiveLock()
    
    func sync<T>(action: ()->T) -> T {
        defer { lock.unlock() }
        lock.lock()
        return action()
    }
}

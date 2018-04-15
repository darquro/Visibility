//
//  ViewableHandler.swift
//  ViewableHandler
//
//  Created by yuki.kuroda on 2018/04/13.
//  Copyright © 2018年 darquro. All rights reserved.
//

import Foundation

public class ViewableHandler<Base> {
    public let base: Base
    var timer: Timer?
    var state: ViewableState = ViewableState.unviewable
    var config = ViewableHandlerConfig()
    var callback: ((ViewableState) -> Void)?
    
    public init (_ base: Base) {
        self.base = base
    }
    
    @objc func checkViewableTimerTask(_ timer: Timer) {
        guard let view = self.base as? UIView else { return }
        let state = view.vh.getViewableState(of: view)
        if self.state != state {
            self.state = state
            self.callback?(self.state)
        }
    }
    
}

public protocol ViewableHandlerCompatible {
    associatedtype Compatible
    var vh: ViewableHandler<Compatible> { get }
}

public extension ViewableHandlerCompatible {
    public var vh: ViewableHandler<Self> {
        if let instance = objc_getAssociatedObject(self, &associatedObjectKey) as? ViewableHandler<Self> {
            return instance
        }
        let instance = ViewableHandler(self)
        objc_setAssociatedObject(self, &associatedObjectKey, instance, .OBJC_ASSOCIATION_RETAIN)
        return instance
    }
}

private var associatedObjectKey: UInt8 = 0

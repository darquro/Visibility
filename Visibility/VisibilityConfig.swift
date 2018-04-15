//
//  VisibilityConfig.swift
//  Visibility
//
//  Created by yuki.kuroda on 2018/04/13.
//  Copyright © 2018年 darquro. All rights reserved.
//

import Foundation

/// Visibility configuration
public struct VisibilityConfig {
    /// Interval time of checking view state (sec)
    public var timeInterval: TimeInterval = 0.5
    
    /// The view rectangle visible ratio in UIWindow (0<..1.0)
    public var intersectionRatio: Float = 0.5
    
    /// The view transparency ratio (0..<1.0)
    public var transparencyRatio: Float = 0
    
    public init() {}
    
    public init(timeInterval: TimeInterval,
                intersectionRatio: Float,
                transparencyRatio: Float) {
        self.timeInterval = timeInterval
        self.intersectionRatio = intersectionRatio
        self.transparencyRatio = transparencyRatio
    }
}

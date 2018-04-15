//
//  ViewableHandlerConfig.swift
//  ViewableHandler
//
//  Created by yuki.kuroda on 2018/04/13.
//  Copyright © 2018年 darquro. All rights reserved.
//

import Foundation

public struct ViewableHandlerConfig {
    public var timeInterval: TimeInterval = 1.0
    public var viewableRatio: Float = 1.0
    public var transparencyRatio: Float = 0
    
    public init() {}
    
    public init(timeInterval: TimeInterval, viewableRatio: Float, transparencyRatio: Float) {
        self.timeInterval = timeInterval
        self.viewableRatio = viewableRatio
        self.transparencyRatio = transparencyRatio
    }
}
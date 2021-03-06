//
//  UIView+Visibility.swift
//  Visibility
//
//  Created by yuki.kuroda on 2018/04/13.
//  Copyright © 2018年 darquro. All rights reserved.
//

import UIKit

extension UIView: VisibilityCompatible {}

extension Visibility where Base: UIView {
    
    /// Change the configuration
    ///
    /// - Parameter config: VisibilityConfig
    /// - Returns: Visibility instance
    public func setConfig(_ config: VisibilityConfig) -> Visibility {
        self.config = config
        return self
    }
    
    /// Change the configuration
    ///
    /// - Parameter block: Update value of argument in this block
    /// - Returns: Visibility instance
    public func setConfig(_ block: @escaping (inout VisibilityConfig) -> Void) -> Visibility {
        block(&self.config)
        return self
    }
    
    /// `changed` is called when visibility is changed
    ///
    /// - Parameter block: You can check the visibility state
    public func changed(_ block: @escaping (VisibilityState) -> Void) {
        if self.config.timeInterval <= 0 {
            print("Visibility error: timeInterval must be greater than 0.")
            return
        }
        if self.config.intersectionRatio <= 0 || self.config.intersectionRatio > 1.0 {
            print("Visibility error: intersectionRatio must be greater than 0 and less than or equal to 1.0.")
            return
        }
        if self.config.transparencyRatio < 0 || self.config.transparencyRatio >= 1.0 {
            print("Visibility error: transparencyRatio must be greater than or equal to 0 and less than 1.0.")
            return
        }
        if self.timer?.isValid ?? false {
            self.timer?.invalidate()
        }
        
        let timer = Timer(timeInterval: self.config.timeInterval, target: self, selector: #selector(visibilityTimerTask(_:)), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .commonModes)
        self.timer = timer
        self.changedCallback = block
    }
    
    /// Stop processing
    public func invalidate() {
        self.timer?.invalidate()
    }
    
    func getVisibilityState(of view: UIView) -> VisibilityState {
        let isVisibleAllViewHierarchy = self.isVisibleAllViewHierarchy(of: view, alpha: CGFloat(self.config.transparencyRatio))
        guard let window = getWindow(of: view) else {
            self.timer?.invalidate()
            return .invisible
        }
        let isInWindow = self.isIntersectRect(target: view, parent: window, ratio: CGFloat(self.config.intersectionRatio))
        return isVisibleAllViewHierarchy && isInWindow ? .visible : .invisible
    }
    
    func isVisibleAllViewHierarchy(of view: UIView, alpha: CGFloat) -> Bool {
        var view: UIView? = view
        while view != nil, let v = view {
            let isHidden = v.isHidden
            let isTransparent = v.alpha < alpha
            if isHidden || isTransparent {
                return false;
            }
            view = v.superview
        }
        return true
    }
    
    func getWindow(of view: UIView) -> UIWindow? {
        var parent = view.superview
        while parent != nil {
            if let window = parent as? UIWindow {
                return window
            }
            parent = parent?.superview
        }
        return nil
    }
    
    func isIntersectRect(target: UIView, parent: UIView, ratio: CGFloat) -> Bool {
        let coordinates = target.convert(target.bounds, to: parent)
        let intersection = coordinates.intersection(parent.frame)
        let intersectionArea = floor(intersection.width * intersection.height)
        guard intersectionArea > 0 else {
            return false
        }
        let targetArea = floor(target.bounds.width * target.bounds.height)
        guard targetArea > 0 else {
            return false
        }
        return intersectionArea >= (targetArea * ratio)
    }
    
}

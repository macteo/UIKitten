//
//  UIView+Align.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 21/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit
import CoreGraphics

extension UIView {
    public func configureAlignConstraints() {
        guard let superview = superview else { return }
        
        if let alignable = self as? Alignable {
            translatesAutoresizingMaskIntoConstraints = false
            
            let padding = CGFloat(alignable.padding)
            
            // TODO: support optional value so we don't do anything and le the autolayout do its job
            guard let align = alignable.align else { return }
            
            if align.contains(.top) {
                superview.addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .top, multiplier: 1, constant: padding))
                let bottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: superview, attribute: .bottom, multiplier: 1, constant: -padding)
                bottomConstraint.priority = 750
                superview.addConstraint(bottomConstraint)
            } else if align.contains(.bottom) {
                superview.addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: superview, attribute: .top, multiplier: 1, constant: padding))
                let bottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: superview, attribute: .bottom, multiplier: 1, constant: -padding)
                bottomConstraint.priority = 750
                superview.addConstraint(bottomConstraint)
            } else if align.contains(.middle) {
                superview.addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: superview, attribute: .top, multiplier: 1, constant: padding))
                superview.addConstraint(NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: superview, attribute: .centerY, multiplier: 1, constant: 0))
                let bottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: superview, attribute: .bottom, multiplier: 1, constant: -padding)
                bottomConstraint.priority = 750
                superview.addConstraint(bottomConstraint)
            } else {
                superview.addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .top, multiplier: 1, constant: padding))
                let bottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: superview, attribute: .bottom, multiplier: 1, constant: -padding)
                bottomConstraint.priority = 750
                superview.addConstraint(bottomConstraint)
            }
            
            if align.contains(.left) {
                superview.addConstraint(NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: superview, attribute: .leading, multiplier: 1, constant: padding))
                superview.addConstraint(NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .lessThanOrEqual, toItem: superview, attribute: .trailing, multiplier: 1, constant: -padding))
            } else if align.contains(.right) {
                superview.addConstraint(NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .greaterThanOrEqual, toItem: superview, attribute: .leading, multiplier: 1, constant: padding))
                superview.addConstraint(NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: superview, attribute: .trailing, multiplier: 1, constant: -padding))
            } else if align.contains(.center) {
                superview.addConstraint(NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .greaterThanOrEqual, toItem: superview, attribute: .leading, multiplier: 1, constant: padding))
                superview.addConstraint(NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .lessThanOrEqual, toItem: superview, attribute: .trailing, multiplier: 1, constant: -padding))
                superview.addConstraint(NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: superview, attribute: .centerX, multiplier: 1, constant: 0))
            } else {
                superview.addConstraint(NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: superview, attribute: .leading, multiplier: 1, constant: padding))
                superview.addConstraint(NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .lessThanOrEqual, toItem: superview, attribute: .trailing, multiplier: 1, constant: -padding))
            }
            
            if let width = alignable.width {
                switch width {
                case .absolute(let points):
                    let widthConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: points)
                    widthConstraint.priority = 750
                    self.addConstraint(widthConstraint)
                    break
                case .container(let ratio):
                    let widthConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: superview, attribute: .width, multiplier: ratio, constant: 0)
                    widthConstraint.priority = 750
                    superview.addConstraint(widthConstraint)
                    break
                case .height(let ratio):
                    let widthConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: self, attribute: .height, multiplier: ratio, constant: 0)
                    widthConstraint.priority = 750
                    self.addConstraint(widthConstraint)
                    break
                }
            }
            
            if let height = alignable.height {
                switch height {
                case .absolute(let points):
                    let heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: points)
                    heightConstraint.priority = 750
                    self.addConstraint(heightConstraint)
                    break
                case .container(let ratio):
                    let heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: superview, attribute: .height, multiplier: ratio, constant: 0)
                    heightConstraint.priority = 750
                    superview.addConstraint(heightConstraint)
                    break
                case .width(let ratio):
                    let heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: self, attribute: .width, multiplier: ratio, constant: 0)
                    heightConstraint.priority = 750
                    self.addConstraint(heightConstraint)
                    break
                }
            }
        } else {
            translatesAutoresizingMaskIntoConstraints = true
            superview.addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .top, multiplier: 1, constant: 0))
            superview.addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: superview, attribute: .bottom, multiplier: 1, constant: 0))
            superview.addConstraint(NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: superview, attribute: .leading, multiplier: 1, constant: 0))
            superview.addConstraint(NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .lessThanOrEqual, toItem: superview, attribute: .trailing, multiplier: 1, constant: 0))
        }
    }    
}

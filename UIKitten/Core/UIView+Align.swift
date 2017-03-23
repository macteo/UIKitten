//
//  UIView+Align.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 21/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit

extension UIView {
    public func configureAlignConstraints() {
        guard let superview = superview else { return }
        
        if let alignable = self as? Alignable {
            translatesAutoresizingMaskIntoConstraints = false
            let align = alignable.align
            let padding = CGFloat(alignable.padding)
            
            if align.contains(.top) {
                superview.addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .top, multiplier: 1, constant: padding))
                superview.addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: superview, attribute: .bottom, multiplier: 1, constant: -padding))
            } else if align.contains(.bottom) {
                superview.addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: superview, attribute: .top, multiplier: 1, constant: padding))
                superview.addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: superview, attribute: .bottom, multiplier: 1, constant: -padding))
            } else if align.contains(.middle) {
                superview.addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: superview, attribute: .top, multiplier: 1, constant: padding))
                superview.addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: superview, attribute: .bottom, multiplier: 1, constant: -padding))
                superview.addConstraint(NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: superview, attribute: .centerY, multiplier: 1, constant: 0))
            } else {
                superview.addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .top, multiplier: 1, constant: padding))
                superview.addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: superview, attribute: .bottom, multiplier: 1, constant: -padding))
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
            
        } else {
            translatesAutoresizingMaskIntoConstraints = true
            superview.addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .top, multiplier: 1, constant: 0))
            superview.addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: superview, attribute: .bottom, multiplier: 1, constant: 0))
            superview.addConstraint(NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: superview, attribute: .leading, multiplier: 1, constant: 0))
            superview.addConstraint(NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .lessThanOrEqual, toItem: superview, attribute: .trailing, multiplier: 1, constant: 0))
        }
    }
}

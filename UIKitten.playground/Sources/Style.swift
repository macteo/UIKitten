//
//  Style.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 10/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import Foundation
import CoreGraphics

public enum Style : String {
    case normal     = "normal"
    case dropShadow = "dropShadow"
    case rounded    = "rounded"
    case glass      = "glass"
    case grouped    = "grouped"
    
    public func cornerRadius(height: CGFloat) -> CGFloat {
        switch self {
        case .normal, .dropShadow, .glass:
            return 4
        case .rounded:
            return height / 2
        case .grouped:
            return 0
        }
    }
    
    public var shadowIsVisible: Bool {
        switch self {
        case .normal, .rounded, .glass, .grouped:
            return false
        case .dropShadow:
            return true
        }
    }
}

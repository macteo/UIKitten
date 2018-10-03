//
//  Size.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 10/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

public enum Size : String {
    case normal     = "normal"
    case large      = "lg"
    case small      = "sm"
    case extraSmall = "xs"
    
    var height : CGFloat {
        switch self {
        case .large:
            return 48
        case .normal:
            return 36
        case .small:
            return 32
        case .extraSmall:
            return 24
        }
    }
    
    var textStyle : UIFont.TextStyle {
        switch self {
        case .large:
            return .headline
        case .normal:
            return .subheadline
        case .small:
            return .caption1
        case .extraSmall:
            return .caption1
        }
    }
    
    func inset(style: Style) -> CGFloat {
        if style == .rounded {
            switch self {
            case .large:
                return 14
            case .normal:
                return 10
            case .small:
                return 8
            case .extraSmall:
                return 6
            }
        } else {
            switch self {
            case .large:
                return 10
            case .normal:
                return 8
            case .small:
                return 6
            case .extraSmall:
                return 4
            }
        }
    }
}

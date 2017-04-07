//
//  BadgeType.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 30/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit

public enum BadgeType : String {
    case normal     = "normal"
    case primary    = "primary"
    case info       = "info"
    case warning    = "warning"
    case danger     = "danger"
    case success    = "success"
    case clean      = "clean"
    
    var backgroundColor : UIColor {
        switch self {
        case .normal:
            return .normal
        case .primary:
            return .primary
        case .info:
            return .info
        case .warning:
            return .warning
        case .danger:
            return .danger
        case .success:
            return .success
        case .clean:
            return .clean
        }
    }
    
    var titleColor : UIColor {
        switch self {
        case .normal, .info, .warning, .danger, .success, .primary:
            return .white
        case .clean:
            return .darkGray
        }
    }
    
    var borderColor : UIColor {
        switch self {
        case .normal, .clean:
            return .lightGrayFlat
        case .info, .warning, .danger, .success, .primary:
            if let darkerColor = backgroundColor.darker(value: 0.1) {
                return darkerColor
            }
            return backgroundColor
        }
    }
    
    var borderWidth : CGFloat {
        switch self {
        case .normal, .clean, .info, .warning, .danger, .success, .primary:
            return 1.0 / UIScreen.main.scale
        }
    }
}


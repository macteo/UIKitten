//
//  TextFieldType.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 10/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit

public enum TextFieldType : String {
    case normal     = "normal"
    case info       = "info"
    case warning    = "warning"
    case danger     = "danger"
    case success    = "success"
    case focused    = "focused"
    
    var backgroundColor : UIColor {
        switch self {
        case .normal:
            return .normal
        case .info:
            return .info
        case .warning:
            return .warning
        case .danger:
            return .danger
        case .success:
            return .success
        case .focused:
            return .focused
        }
    }
    
    var titleColor : UIColor {
        switch self {
        case .normal, .info, .warning, .danger, .success, .focused:
            return .text
        }
    }
    
    var borderColor : UIColor {
        switch self {
        case .normal:
            return .mediumGray
        case .info, .warning, .danger, .success:
            return backgroundColor
        case .focused:
            return .focused
        }
    }
    
    var borderWidth : CGFloat {
        switch self {
        case .normal, .info, .warning, .danger, .success, .focused:
            return 1
        }
    }
}

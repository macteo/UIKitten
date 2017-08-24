//
//  Align.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 13/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import CoreGraphics
import UIKit

public struct Align: OptionSet {
    public let rawValue: Int
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    public static let top      = Align(rawValue: 1 << 0)
    public static let middle   = Align(rawValue: 1 << 1)
    public static let bottom   = Align(rawValue: 1 << 2)
    public static let left     = Align(rawValue: 1 << 3)
    public static let center   = Align(rawValue: 1 << 4)
    public static let right    = Align(rawValue: 1 << 5)
}

public protocol Alignable {
    var align : Align? { get set }
    var margin : UIEdgeInsets { get set }
    var width : Width? { get set }
    var height : Height? { get set }
    var vertical : Vertical? { get set }
    var horizontal : Horizontal? { get set }
}

public enum Width {
    case absolute(points: CGFloat)
    case container(ratio: CGFloat)
    case height(ratio: CGFloat)
}

public enum Height {
    case absolute(points: CGFloat)
    case container(ratio: CGFloat)
    case width(ratio: CGFloat)
}

public enum Vertical {
    case above(view: UIView)
    case below(view: UIView)
    
    var top : UIView? {
        switch self {
        case .below(let view):
            return view
        default:
            return nil
        }
    }
    
    var bottom : UIView? {
        switch self {
        case .above(let view):
            return view
        default:
            return nil
        }
    }
}

public enum Horizontal {
    case leading(view: UIView)
    case trailing(view: UIView)
    
    var left : UIView? {
        switch self {
        case .leading(let view):
            return view
        default:
            return nil
        }
    }
    
    var right : UIView? {
        switch self {
        case .trailing(let view):
            return view
        default:
            return nil
        }
    }
}

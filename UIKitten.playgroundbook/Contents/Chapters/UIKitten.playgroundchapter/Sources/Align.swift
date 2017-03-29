//
//  Align.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 13/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import CoreGraphics

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
    // TODO: move to UIEdgeInsets
    var padding : Int { get set }
    var width : Width? { get set }
    var height : Height? { get set }
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

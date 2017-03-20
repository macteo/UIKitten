//
//  Align.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 13/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

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

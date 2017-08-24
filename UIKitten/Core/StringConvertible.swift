//
//  StringSerializable.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 23/08/16.
//  Copyright © 2016 Dolomate. All rights reserved.
//

protocol StringConvertible : StringSerializable {
    init?(string: String)
}

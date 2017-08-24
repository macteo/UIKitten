//
//  Double.swift
//  Tralio
//
//  Created by Matteo Gavagnin on 22/08/16.
//  Copyright © 2016 Dolomate. All rights reserved.
//

import Foundation

extension Double {
    func format(d: Int) -> String {
        return String(format: "%.\(d)f", self)
    }
}

extension Float {
    func format(d: Int) -> String {
        return String(format: "%.\(d)f", self)
    }
}

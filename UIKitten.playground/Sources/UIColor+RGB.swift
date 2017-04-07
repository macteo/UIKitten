//
//  Colors.swift
//  Unin.io
//
//  Created by Matteo Gavagnin on 26/09/16.
//  Copyright © 2016 ContactLab. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func color(rgbString: String, alpha: CGFloat = 1.0) -> UIColor {
        guard let colorInt = UInt(rgbString, radix: 16) else {
            print("UIColor+RGB: invalid color \(rgbString)")
            return UIColor.red
        }
        return UIColor.color(rgb: colorInt, alpha: alpha)
    }
    
    class func color(rgb: UInt, alpha: CGFloat = 1.0) -> UIColor {
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255
        let green = CGFloat((rgb & 0xFF00) >> 8) / 255
        let blue = CGFloat(rgb & 0xFF) / 255
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    func lighter(value: CGFloat = 0.1) -> UIColor? {
        return adjust(value: abs(value))
    }
    
    func darker(value:CGFloat = 0.1) -> UIColor? {
        return adjust(value: -1 * abs(value))
    }
    
    func adjust(value: CGFloat = 0.3) -> UIColor? {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 1;
        if(getRed(&r, green: &g, blue: &b, alpha: &a)){
            let color = UIColor(red: max(min(r + value, 1.0), 0.0),
                                green: max(min(g + value, 1.0), 0.0),
                                blue: max(min(b + value, 1.0), 0.0),
                                alpha: a)
            return color
        } else {
            return nil
        }
    }
}

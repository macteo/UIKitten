//
//  Colors.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 09/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit

extension UIColor {
    
    public class var redFlat: UIColor {
        return UIColor.color(rgb: 0xf67a6e)
    }
    
    public class var seaFlat: UIColor {
        return UIColor.color(rgbString: "41cac0")
    }
    
    public class var blueFlat: UIColor {
        return UIColor.color(rgbString: "57BEE2")
    }
    
    public class var lightGrayFlat : UIColor {
        return UIColor(colorLiteralRed: 150/255, green: 160/255, blue: 180/255, alpha: 0.3)
    }
    
    public class var tableGray : UIColor {
        return UIColor.color(rgbString: "c7c7cc")
    }
    
    public class var defaultTableSelected : UIColor {
        return UIColor.color(rgbString: "d9d9d9")
    }

    public class var text: UIColor {
        return UIColor.color(rgbString: "7777777")
    }
    
    public class var mediumGray : UIColor {
        return UIColor.color(rgbString: "e2e2e4")
    }
}

extension UIColor {
    public class var success: UIColor {
        return UIColor.color(rgbString: "78CD51")
    }
    
    public class var primary: UIColor {
        return UIColor.color(rgbString: "41cac0")
    }
    
    public class var info: UIColor {
        return UIColor.color(rgbString: "58c9f3")
    }
    
    public class var danger: UIColor {
        return UIColor.color(rgbString: "ff6c60")
    }
    
    public class var warning: UIColor {
        return UIColor.color(rgbString: "f1c500")
    }
    
    public class var normal: UIColor {
        return UIColor.color(rgbString: "bec3c7")
    }
    
    public class var focused: UIColor {
        return UIColor.color(rgbString: "517397")
    }
    
    public class var clean: UIColor {
        return .white
    }
}

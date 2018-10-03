//
//  Counter+Icon.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 30/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit
#if COCOAPODS
    import FontAwesome_swift
#endif

public extension Counter {
    
    public convenience init(icon: FontAwesome, value: Int? = nil, caption: String? = nil) {
        self.init(frame: CGRect(x: 0, y: 0, width: 100, height: 22))
        commonInit()
        
        let defaultPointSize : CGFloat = 128
        
        // TODO: grab type from theme so the color is correct
        let normalImage = UIImage.fontAwesomeIcon(name: icon, style: .regular, textColor: .white, size: CGSize(width: defaultPointSize, height: defaultPointSize)).withRenderingMode(.alwaysTemplate)
        
        image = normalImage
    }
}


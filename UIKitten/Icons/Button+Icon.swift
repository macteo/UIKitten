//
//  Button+Tap.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 13/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit
#if COCOAPODS
    import FontAwesome_swift
#endif

public extension Button {
    
    public convenience init(icon: FontAwesome, title: String? = nil, position: ImagePosition = .left) {
        self.init(frame: CGRect(x: 0, y: 0, width: 100, height: 22))
        commonInit()

        let defaultPointSize : CGFloat = 22
        
        // TODO: support dynamic size

        setTitle(title, for: .normal)
        
        if position == .left {
            semanticContentAttribute = .forceLeftToRight
        } else {
            semanticContentAttribute = .forceRightToLeft
        }
        
        let normalImage = UIImage.fontAwesomeIcon(name: icon, textColor: type.titleColor, size: CGSize(width: defaultPointSize, height: defaultPointSize))
        
        setImage(normalImage, for: .normal)
        
        if let darkerColor = type.titleColor.darker(value: 0.1) {
            let selectedImage = UIImage.fontAwesomeIcon(name: icon, textColor: darkerColor, size: CGSize(width: defaultPointSize, height: defaultPointSize))
            setImage(selectedImage, for: .selected)
            setImage(selectedImage, for: .highlighted)
        }
        
        if let lighterColor = type.titleColor.lighter(value: 0.2) {
            let disabledImage = UIImage.fontAwesomeIcon(name: icon, textColor: lighterColor, size: CGSize(width: defaultPointSize, height: defaultPointSize))
            setImage(disabledImage, for: .disabled)
        }
    }
}

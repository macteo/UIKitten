//
//  Label.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 30/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit

public class Label : UILabel {
    public var contentAlign: Align = .center
    
    public override func drawText(in rect: CGRect) {
        var eRect = rect
        if contentAlign.contains(.top) {
            eRect.size.height = sizeThatFits(rect.size).height
        } else if contentAlign.contains(.bottom) {
            let height = sizeThatFits(rect.size).height
            eRect.origin.y += rect.size.height - height
            eRect.size.height = height
        }
        super.drawText(in: eRect)
    }
}

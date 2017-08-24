//
//  TextView.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 23/08/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit

public class TextView : UITextView, Alignable {
    public var width: Width?
    public var height: Height?
    public var margin = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    public var align : Align? = [.top, .left]
    
    public var vertical : Vertical?
    public var horizontal : Horizontal?
}


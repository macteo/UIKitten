//
//  Cell.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 30/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit

public protocol Cell {
    func populate(item: ListItem, width: CGFloat)
    init(frame: CGRect)
    var frame                   : CGRect { get set }
    var delegate                : CellDelegate? { get set }
    var separatorInset          : UIEdgeInsets { get set }
    var separatorIsVisible      : Bool { get set }
    var minHeight               : CGFloat { get set }
    // TODO: should be exposed?
    var containedView           : UIView? { get set }
    var accessoryViewIsVisible  : Bool { get set }
    var desiredSize             : CGSize { get set }
    var isHeightCalculated      : Bool { get set }
    var contentView             : UIView { get }
}

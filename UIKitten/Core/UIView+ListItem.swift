//
//  UIView+ListItem.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 23/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit

extension UIView : ListItem {
    public func itemTitle() -> String? {
        return nil
    }
    
    public func itemSubtitle() -> String? {
        return nil
    }
    
    public func itemValue() -> Int? {
        return nil
    }
    
    public func itemImage() -> UIImage? {
        return nil
    }
    
    public func itemImageUrl() -> URL? {
        return nil
    }

    public func itemAction() -> ((_ cell : Cell?, _ selected: Bool) -> Void)? {
        return nil
    }
    
    public func itemView() -> UIView? {
        return self
    }
    
    public func cellType() -> CellType {
        return .view
    }
}

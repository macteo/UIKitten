//
//  CounterCell.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 30/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit

public class CounterCell: BaseCell {
    let counter = Counter(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
    
    required public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func commonInit() {
        super.commonInit()
        mainView.addSubview(counter)
    }
    
    override public func prepareForReuse() {
        super.prepareForReuse()
    
        counter.caption = nil
        counter.value = nil
    }
    
    override public func populate(item: ListItem, width: CGFloat) {
        counter.caption = item.itemTitle()
        counter.value = item.itemValue()
        counter.image = item.itemImage()
        
        super.populate(item: item, width: width)
    }
}

//
//  Label.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 30/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit

public class Label : UILabel, Alignable {
    public var width: Width?
    public var height: Height?
    
    public var margin = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) {
        didSet {
            layoutIfNeeded()
        }
    }
    
    public var align : Align? = [.top, .left] {
        didSet {
            layoutIfNeeded()
        }
    }
    
    public var horizontal : Horizontal? {
        didSet {
            layoutIfNeeded()
        }
    }
    
    public var vertical : Vertical? {
        didSet {
            layoutIfNeeded()
        }
    }
    
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
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public convenience init(text: String) {
        self.init(frame: CGRect(x: 0, y: 0, width: 100, height: 22))
        self.text = text
        commonInit()
    }
    
    func commonInit() {
        backgroundColor = UIColor.green.withAlphaComponent(0.25)
        numberOfLines = 0
        if #available(iOS 10, *) { } else {
            // Only for iOS 9
            NotificationCenter.default.addObserver(self, selector: #selector(self.contentSizeDidChange(notification:)), name: Notification.Name.UIContentSizeCategoryDidChange, object: nil)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func contentSizeDidChange(notification: Notification) {
        traitCollectionDidChange(nil)
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        // layoutIfNeeded()
        // TODO: adapt the font size
        /*
        if let textStyle = titleLabel?.font.fontDescriptor.object(forKey: UIFontDescriptorTextStyleAttribute) as? UIFontTextStyle {
            titleLabel?.font = UIFont.preferredFont(forTextStyle: textStyle)
        }
         */
    }
    
    public func text(_ text: String) -> Label {
        self.text = text
        return self
    }
    
    public func add(to view: UIView) -> Label {
        view.addSubview(self)
        return self
    }
    
    public func align(_ align: Align) -> Label {
        self.align = align
        return self
    }
    
    public func horizontal(_ horizontal: Horizontal) -> Label {
        self.horizontal = horizontal
        return self
    }
    
    public func vertical(_ vertical: Vertical) -> Label {
        self.vertical = vertical
        return self
    }
    
    public func below(_ view: UIView) -> Label {
        self.vertical = Vertical.below(view: view)
        return self
    }
    
    public func above(_ view: UIView) -> Label {
        self.vertical = Vertical.above(view: view)
        return self
    }
    
    public func leading(_ view: UIView) -> Label {
        self.horizontal = Horizontal.leading(view: view)
        return self
    }
    
    public func trailing(_ view: UIView) -> Label {
        self.horizontal = Horizontal.trailing(view: view)
        return self
    }
    
    public func margin(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> Label {
        self.margin = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    
    override public func didMoveToSuperview() {
        super.didMoveToSuperview()
        configureAlignConstraints()
    }
}

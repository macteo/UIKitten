//
//  Badge.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 30/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit

public class Badge : Label, Alignable {
    public var insets = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
    
    // TODO: move to the Label class
    // MARK: Alignable protocol
    
    public var width: Width?
    public var height: Height?
    public var margin = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    public var align : Align?
    
    // MARK: View Lifecycle
    
    public var value: String? {
        didSet {
            if (oldValue == nil || oldValue == "") && (value != nil && value != "") {
                text = value
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: UIViewAnimationOptions.beginFromCurrentState, animations: {
                    self.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: { (completed) in
                    
                })
            }
        }
        willSet {
            if (value != nil && value != "") && (newValue == nil || newValue == "") {
                UIView.animate(withDuration: 0.25, animations: { 
                    self.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                }, completion: { (completed) in
                    self.text = newValue
                })
            }
        }
    }
        
    override public required init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        text = nil
        type = .danger
        textAlignment = .center
        
        transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        
        layer.cornerRadius = bounds.size.height / 2
        layer.masksToBounds = true
        
        font = UIFont.preferredFont(forTextStyle: .caption2)
        
        // TODO: move to the Label class
        if #available(iOS 10, *) { } else {
            // Only for iOS 9
            NotificationCenter.default.addObserver(self, selector: #selector(self.contentSizeDidChange(notification:)), name: Notification.Name.UIContentSizeCategoryDidChange, object: nil)
        }
    }
    
    public var type : BadgeType = .danger {
        didSet {
            backgroundColor = type.backgroundColor
            textColor = type.titleColor
            layer.borderColor = type.borderColor.cgColor
            layer.borderWidth = type.borderWidth
            tintColor = type.titleColor
        }
    }
    
    @IBInspectable public var typeString : String = "normal" {
        didSet {
            guard let typed = BadgeType(rawValue: typeString) else { return }
            type = typed
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.height / 2
    }
    
    // TODO: move to the Label class
    func contentSizeDidChange(notification: Notification) {
        traitCollectionDidChange(nil)
    }
    
    // TODO: move to the Label class
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if let valueStyle = font.fontDescriptor.object(forKey: UIFontDescriptorTextStyleAttribute) as? UIFontTextStyle {
            font = UIFont.preferredFont(forTextStyle: valueStyle)
        }
    }
    
    // TODO: move to the Label class
    public func add(to view: UIView) -> UIView {
        view.addSubview(self)
        return self
    }
    
    // TODO: move to the Label class
    override public func didMoveToSuperview() {
        super.didMoveToSuperview()
        configureAlignConstraints()
    }
    
    public override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    
    override public func sizeThatFits(_ size: CGSize) -> CGSize {
        var adjSize = super.sizeThatFits(size)
        adjSize.width += insets.left + insets.right
        adjSize.height += insets.top + insets.bottom
        
        layer.cornerRadius = adjSize.height / 2
        
        if adjSize.width < adjSize.height {
            adjSize.width = adjSize.height
        }
        
        return adjSize
    }
    
    override public var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.width += insets.left + insets.right
        contentSize.height += insets.top + insets.bottom
        
        if contentSize.width < contentSize.height {
            contentSize.width = contentSize.height
        }
        
        return contentSize
    }
    
    public func snap(to view: UIView) -> Badge {
        guard let superview = view.superview else { return self }
        superview.addSubview(self)
        let xConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        xConstraint.priority = 500
        superview.addConstraint(xConstraint)
        let trailingConstraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .lessThanOrEqual, toItem: view, attribute: .trailing, multiplier: 1, constant: 10)
        trailingConstraint.priority = 750
        superview.addConstraint(trailingConstraint)
        superview.addConstraint(NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0))
        return self
    }
}

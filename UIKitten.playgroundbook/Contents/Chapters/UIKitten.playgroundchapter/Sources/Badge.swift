//
//  Badge.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 30/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

public class Badge : Label, Alignable {
    public var insets = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
    
    // TODO: move to the Label class
    // MARK: Alignable protocol
    
    public var width: Width?
    public var height: Height?
    public var padding : Int = 0
    public var align : Align?
    
    // MARK: View Lifecycle
    
    // TODO: change to style
    public var color : UIColor? = .warning {
        didSet {
            backgroundColor = color
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
        // TODO: take from theme
        cornerRadius = bounds.size.height / 2
        layer.masksToBounds = true
        
        font = UIFont.preferredFont(forTextStyle: .caption2)
        
        color = .warning
        textColor = .white
        
        // TODO: move to the Label class
        if #available(iOS 10, *) { } else {
            // Only for iOS 9
            NotificationCenter.default.addObserver(self, selector: #selector(self.contentSizeDidChange(notification:)), name: Notification.Name.UIContentSizeCategoryDidChange, object: nil)
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        cornerRadius = bounds.size.height / 2
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
        
        return adjSize
    }
    
    override public var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.width += insets.left + insets.right
        contentSize.height += insets.top + insets.bottom
        
        return contentSize
    }
    
    public func snap(to view: UIView) -> Badge {
        guard let superview = view.superview else { return self }
        superview.addSubview(self)
        superview.addConstraint(NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0))
        superview.addConstraint(NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0))
        return self
    }
}

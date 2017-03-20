//
//  Button.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 09/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit

public class Button: UIButton {

    var bottomBorder : UIView?
    let glassEffect = UIBlurEffect(style: .light)
    var glassBackground : UIVisualEffectView?
    
    var originalFrame : CGRect?
    
    var heightConstraint : NSLayoutConstraint?
    
    @IBInspectable public var multiline : Bool = true {
        didSet {
            layoutIfNeeded()
        }
    }
    
    @IBInspectable public var fitTitle : Bool = true {
        didSet {
            layoutIfNeeded()
        }
    }
    
    public var type : ButtonType = .normal {
        didSet {
            layoutIfNeeded()
        }
    }
    
    @IBInspectable public var typeString : String = "normal" {
        didSet {
            guard let typed = ButtonType(rawValue: typeString) else { return }
            type = typed
        }
    }
    
    public var style : Style = .normal {
        didSet {
            layoutIfNeeded()
        }
    }
    
    @IBInspectable public var styleString : String = "normal" {
        didSet {
            guard let styled = Style(rawValue: styleString) else { return }
            style = styled
        }
    }
    
    public var size : Size = .normal {
        didSet {
            layoutIfNeeded()
        }
    }
    
    @IBInspectable public var sizeString : String = "normal" {
        didSet {
            guard let sized = Size(rawValue: sizeString) else { return }
            size = sized
        }
    }

    public override var buttonType: UIButtonType {
        return .custom
    }
    
    public func title(_ title: String) -> Button {
        setTitle(title, for: .normal)
        return self
    }
    
    public func style(_ style: Style) -> Button {
        self.style = style
        return self
    }
    
    public func type(_ type: ButtonType) -> Button {
        self.type = type
        return self
    }
    
    public func size(_ size: Size) -> Button {
        self.size = size
        return self
    }
    
    public override func setTitle(_ title: String?, for state: UIControlState) {
        super.setTitle(title, for: state)
        updateFrameToFitTitle()
    }
    
    func updateFrameToFitTitle() {
        guard fitTitle else { return }
        guard let originalFrame = originalFrame else { return }
        sizeToFit()
        
        if multiline == false {
            frame.size = frame.insetBy(dx: -size.inset(style: style), dy: 0).size
            frame.size.height = max(size.height, frame.size.height)
        } else {
            frame.size = frame.insetBy(dx: -size.inset(style: style), dy: -size.inset(style: style)).size
            frame.size.height = max(size.height, frame.size.height)
            
        }
        if heightConstraint != nil {
            heightConstraint?.constant = frame.size.height
        } else {
            heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: frame.size.height)
            heightConstraint?.priority = 1000
            addConstraint(heightConstraint!)
        }
        
        layer.cornerRadius = style.cornerRadius(height: frame.size.height)
        frame.origin = originalFrame.origin
    }
    
    @IBInspectable public var bottomBorderWidth: CGFloat {
        set {
            addBottomBorder()
            guard let bottomBorder = bottomBorder else { return }
            bottomBorder.layer.borderWidth = newValue
            bottomBorder.frame = CGRect(x: -bottomBorderWidth, y: -bottomBorderWidth, width: frame.size.width + bottomBorderWidth * 2, height: frame.size.height + bottomBorderWidth)
        }
        get {
            guard let bottomBorder = bottomBorder else { return 0 }
            return bottomBorder.layer.borderWidth
        }
    }
    
    public override var isSelected: Bool {
        didSet {
            var colorDelta : CGFloat = 0.1
            if isSelected {
                colorDelta = 0.2
            }
            bottomBorder?.layer.borderColor = type.backgroundColor.darker(value: colorDelta)?.cgColor
        }
    }
    
    public override var isHighlighted: Bool {
        didSet {
            var colorDelta : CGFloat = 0.1
            if isHighlighted {
                colorDelta = 0.2
            }
            bottomBorder?.layer.borderColor = type.backgroundColor.darker(value: colorDelta)?.cgColor
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            let colorDelta : CGFloat = 0.1
            bottomBorder?.layer.borderColor = type.backgroundColor.darker(value: colorDelta)?.cgColor
        }
    }
    
    override var cornerRadius: CGFloat {
        set {
            addBottomBorder()
            guard let bottomBorder = bottomBorder else { return }
            bottomBorder.layer.cornerRadius = newValue * 2
            bottomBorder.clipsToBounds = newValue * 2 > 0
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            guard let bottomBorder = bottomBorder else { return 0 }
            return bottomBorder.layer.cornerRadius
        }
    }
    
    public override var backgroundColor: UIColor? {
        didSet {
            super.backgroundColor = backgroundColor
            bottomBorder?.layer.borderColor = backgroundColor?.darker(value: 0.1)?.cgColor
        }
    }
    
    override func setBackgroundColor(_ color: UIColor, forState: UIControlState) {
        super.setBackgroundColor(color, forState: forState)
        if forState == .normal {
            bottomBorder?.layer.borderColor = color.darker(value: 0.1)?.cgColor
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public convenience init(title: String) {
        self.init(frame: CGRect(x: 0, y: 0, width: 100, height: 22))
        
        commonInit()
        
        setTitle(title, for: .normal)
    }
    
    public override var intrinsicContentSize: CGSize {
        var intrinsicSize = super.intrinsicContentSize
        
        if multiline == false {
            intrinsicSize.width = intrinsicSize.width + size.inset(style: style) * 2
            intrinsicSize.height = size.height
        } else {
            intrinsicSize.width = intrinsicSize.width + size.inset(style: style) * 2
            intrinsicSize.height = max(intrinsicSize.height + size.inset(style: style) * 2, size.height)
        }
        cornerRadius = style.cornerRadius(height: intrinsicSize.height)
        
        if heightConstraint != nil {
            heightConstraint?.constant = intrinsicSize.height
        } else {
            heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: intrinsicSize.height)
            heightConstraint?.priority = 1000
            addConstraint(heightConstraint!)
        }
        return intrinsicSize
    }
    
    func commonInit() {
        if originalFrame == nil {
            originalFrame = frame
        }
        titleLabel?.textAlignment = .center

        layoutIfNeeded()
        
        if #available(iOS 10, *) { } else {
            // Only for iOS 8 and 9
            NotificationCenter.default.addObserver(self, selector: #selector(self.contentSizeDidChange(notification:)), name: Notification.Name.UIContentSizeCategoryDidChange, object: nil)
        }
        
        addTarget(self, action: #selector(touchUpInside(_:)), for: .touchUpInside)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func contentSizeDidChange(notification: Notification) {
        traitCollectionDidChange(nil)
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if let textStyle = titleLabel?.font.fontDescriptor.object(forKey: UIFontDescriptorTextStyleAttribute) as? UIFontTextStyle {
             titleLabel?.font = UIFont.preferredFont(forTextStyle: textStyle)
        }
        layoutIfNeeded()
    }
    
    public var action : ((Void) -> Void)?
    
    public var align : Align = [.top, .left] {
        didSet {
            layoutIfNeeded()
        }
    }
    
    public var padding : Int = 0 {
        didSet {
            layoutIfNeeded()
        }
    }
    
    public func tap(_ action: @escaping (Void) -> Void) -> Button {
        self.action = action
        return self
    }
    
    func touchUpInside(_ button: UIButton) {
        if let action = action {
            action()
        }
    }
    
    public func add(to view: UIView) -> Button {
        view.addSubview(self)
        layoutIfNeeded()
        return self
    }
    
    public func align(_ align: Align) -> Button {
        self.align = align
        return self
    }
    
    public func padding(_ padding: Int) -> Button {
        self.padding = padding
        return self
    }
    
    func addBottomBorder() {
        if bottomBorder == nil {
            bottomBorder = UIView(frame: CGRect(x: 0, y: 0, width: 4, height: 4))
            guard let bottomBorder = bottomBorder else { return }
            bottomBorder.frame = CGRect(x: -bottomBorderWidth, y: -bottomBorderWidth, width: frame.size.width + bottomBorderWidth * 2, height: frame.size.height + bottomBorderWidth)
            bottomBorder.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            bottomBorder.backgroundColor = .clear
            bottomBorder.isUserInteractionEnabled = false
            addSubview(bottomBorder)
        }
    }
    
    public override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        if style == .glass {
            if glassBackground == nil {
                glassBackground = UIVisualEffectView(effect: glassEffect)
                guard let glassBackground = glassBackground else { return }
                glassBackground.frame = bounds
                glassBackground.isUserInteractionEnabled = false
                glassBackground.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                glassBackground.backgroundColor = .clear
                addSubview(glassBackground)
                sendSubview(toBack: glassBackground)
            }
        } else {
            glassBackground?.removeFromSuperview()
            glassBackground = nil
        }
        
        if style == .dropShadow {
            addBottomBorder()
        } else {
            bottomBorder?.removeFromSuperview()
            bottomBorder = nil
        }
        
        // TODO: convert to autolayout
        
        if align.contains(.top) {
            if align.contains(.left) {
                autoresizingMask = [.flexibleBottomMargin, .flexibleRightMargin]
            } else if align.contains(.right) {
                autoresizingMask = [.flexibleBottomMargin, .flexibleLeftMargin]
            } else if align.contains(.center) {
                autoresizingMask = [.flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
            }
        } else if align.contains(.bottom) {
            if align.contains(.left) {
                autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin]
            } else if align.contains(.right) {
                autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin]
            } else if align.contains(.center) {
                autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin, .flexibleRightMargin]
            }
        } else if align.contains(.middle) {
            if align.contains(.left) {
                autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleRightMargin]
            } else if align.contains(.right) {
                autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin]
            } else if align.contains(.center) {
                autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
            }
        }
        
        if glassBackground != nil {
            setBackgroundColor(type.backgroundColor.withAlphaComponent(0.5), forState: .normal)
        } else {
            setBackgroundColor(type.backgroundColor, forState: .normal)
        }
        
        setTitleColor(type.titleColor, for: .normal)
        
        if let darkerTitleColor = type.titleColor.darker(value: 0.1) {
            setTitleColor(darkerTitleColor, for: .selected)
            setTitleColor(darkerTitleColor, for: .highlighted)
        }
        
        if let lighterTitleColor = type.titleColor.lighter(value: 0.2) {
            setTitleColor(lighterTitleColor, for: .disabled)
        }
        
        if let darkerBackgroundColor = type.backgroundColor.darker(value: 0.1) {
            setBackgroundColor(darkerBackgroundColor, forState: .highlighted)
            setBackgroundColor(darkerBackgroundColor, forState: .selected)
        }
        
        if let lighterBackgroundColor = type.backgroundColor.lighter(value: 0.2) {
            setBackgroundColor(lighterBackgroundColor, forState: .disabled)
        }
        
        layer.borderColor = type.borderColor.cgColor
        layer.borderWidth = type.borderWidth
        
        cornerRadius = style.cornerRadius(height: frame.size.height)
        bottomBorder?.isHidden = !style.shadowIsVisible
        
        if let _ = titleLabel?.font.fontDescriptor.object(forKey: UIFontDescriptorTextStyleAttribute) as? UIFontTextStyle {
            titleLabel?.font = UIFont.preferredFont(forTextStyle: size.textStyle)
        }
        
        if multiline {
            titleLabel?.numberOfLines = 0
        } else {
            titleLabel?.numberOfLines = 1
        }
        
        updateFrameToFitTitle()
        
        bottomBorderWidth = style.cornerRadius(height: frame.size.height)
        
        guard let view = superview else { return }
        
        // TODO: convert to autolayout as this doesn't work to autoresize cells
        if align.contains(.top) {
            frame.origin.y = CGFloat(padding)
        } else if align.contains(.bottom) {
            frame.origin.y = view.bounds.size.height - bounds.size.height - CGFloat(padding)
        } else if align.contains(.middle) {
            frame.origin.y = (view.bounds.size.height - bounds.size.height) / 2
        }
        if align.contains(.left) {
            frame.origin.x = CGFloat(padding)
        } else if align.contains(.right) {
            frame.origin.x = view.bounds.size.width - bounds.size.width - CGFloat(padding)
        } else if align.contains(.center) {
            frame.origin.x = (view.bounds.size.width - bounds.size.width) / 2
        }
        
    }
    
    public var image : UIImage? {
        didSet {
            setImage(image, for: .normal)
        }
    }
    
    var imagePosition : ImagePosition = .left {
        didSet {
            if imagePosition == .left {
                semanticContentAttribute = .forceLeftToRight
            } else {
                semanticContentAttribute = .forceRightToLeft
            }
        }
    }
    
    public func imagePosition(_ position: ImagePosition) -> Button {
        self.imagePosition = position
        return self
    }
}

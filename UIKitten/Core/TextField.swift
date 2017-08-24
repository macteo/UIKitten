//
//  TextField.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 10/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit

public class TextField: UITextField, Alignable {

    public var width: Width? = .container(ratio: 0.8)
    public var height: Height?
    public var vertical : Vertical?
    public var horizontal : Horizontal?
    
    let imagePadding = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 0)
    
    var validations : [Validation]?
    var validationType : TextFieldType?
    
    public var margin = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)

    public func align(_ align: Align) -> TextField {
        self.align = align
        return self
    }

    var leftImage : UIImage? {
        didSet {
            if leftImage != nil {
                leftViewMode = .always
                let leftContainer = UIView(frame: CGRect(x: 0, y: 0, width: imageSize.width + imagePadding.right, height: imageSize.height))
                leftContainer.backgroundColor = .clear
                let leftImageView = UIImageView(frame: CGRect(x: imagePadding.left, y: 0, width: imageSize.width, height: imageSize.height))
                leftImageView.image = leftImage
                leftImageView.contentMode = .scaleAspectFit
                leftImageView.tintColor = currentType.borderColor
                leftContainer.addSubview(leftImageView)
                leftView = leftContainer
            } else {
                leftView = nil
                leftViewMode = .never
            }
        }
    }

    var rightImage : UIImage? {
        didSet {
            if rightImage != nil {
                rightViewMode = .always
                let rightContainer = UIView(frame: CGRect(x: 0, y: 0, width: imageSize.width + imagePadding.left, height: imageSize.height))
                rightContainer.backgroundColor = .clear
                let rightImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
                rightImageView.image = rightImage
                rightImageView.contentMode = .scaleAspectFit
                rightImageView.tintColor = currentType.borderColor
                rightContainer.addSubview(rightImageView)
                rightView = rightContainer
            } else {
                rightView = nil
                rightViewMode = .never
            }
        }
    }
    
    var imageSize : CGSize {
        return CGSize(width: bounds.size.height - imagePadding.top - imagePadding.bottom, height: bounds.size.height - imagePadding.top - imagePadding.bottom)
    }
    
    public var style : Style = .normal {
        didSet {
            updateBorder()
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
            updateBorder()
        }
    }
    
    @IBInspectable public var sizeString : String = "normal" {
        didSet {
            guard let sized = Size(rawValue: sizeString) else { return }
            size = sized
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        var intrinsicSize = super.intrinsicContentSize
        
        intrinsicSize.width = intrinsicSize.width + size.inset(style: style) * 2
        intrinsicSize.height = size.height
        layer.cornerRadius = style.cornerRadius(height: intrinsicSize.height)
        return intrinsicSize
    }
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        let defaultRect = super.textRect(forBounds: bounds)
        let inset = size.inset(style: style)
        return defaultRect.insetBy(dx: inset, dy: 0)
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return super.editingRect(forBounds: bounds).insetBy(dx: size.inset(style: style), dy: 0)
    }
    
    public override func becomeFirstResponder() -> Bool {
        defer { updateBorder() }
        return super.becomeFirstResponder()
    }
    
    public override func resignFirstResponder() -> Bool {
        defer { updateBorder() }
        return super.resignFirstResponder()
    }
    
    public override var isSelected: Bool {
        didSet {
            updateBorder()
        }
    }
    
    public var align : Align? {
        didSet {
            // TODO: eventually support alignment when adding it as subview
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
    
    func commonInit() {
        backgroundColor = .white
        borderStyle = .none
        
        updateBorder()
        
        NotificationCenter.default.addObserver(self, selector: #selector(contentSizeDidChange(notification:)), name: Notification.Name.UIContentSizeCategoryDidChange, object: nil)
        
        addTarget(self, action: #selector(onEditingChange(field:)), for: .editingChanged)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func contentSizeDidChange(notification: Notification) {
        traitCollectionDidChange(nil)
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if let textStyle = font?.fontDescriptor.object(forKey: UIFontDescriptorTextStyleAttribute) as? UIFontTextStyle {
            font = UIFont.preferredFont(forTextStyle: textStyle)
        }
    }
    
    var currentType : TextFieldType {
        var type = TextFieldType.normal
        
        if isEditing {
            type = TextFieldType.focused
        }
        
        if let validationType = validationType {
            type = validationType
        }
        
        return type
    }
    
    func updateBorder() {
        let borderColorAnimation = CABasicAnimation(keyPath: "borderColor")
        borderColorAnimation.fromValue = layer.borderColor
        borderColorAnimation.toValue = currentType.borderColor.cgColor
        layer.borderColor = currentType.borderColor.cgColor
        
        let borderWidthAnimation = CABasicAnimation(keyPath: "borderWidth")
        borderWidthAnimation.fromValue = layer.borderWidth
        borderWidthAnimation.toValue = currentType.borderWidth
        layer.borderWidth = currentType.borderWidth
        
        let cornerRadiusAnimation = CABasicAnimation(keyPath: "cornerRadius")
        cornerRadiusAnimation.fromValue = layer.cornerRadius
        cornerRadiusAnimation.toValue = style.cornerRadius(height: bounds.height)
        layer.cornerRadius = style.cornerRadius(height: bounds.height)
        
        let borderAnimationGroup = CAAnimationGroup()
        borderAnimationGroup.animations = [borderColorAnimation, borderWidthAnimation, cornerRadiusAnimation]
        borderAnimationGroup.duration = 0.25
        borderAnimationGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        layer.add(borderAnimationGroup, forKey: "border width and color, corner radius")
        
        textColor = currentType.titleColor
        tintColor = currentType.borderColor
        
        leftView?.subviews.first?.tintColor = currentType.borderColor
        rightView?.subviews.first?.tintColor = currentType.borderColor
        
        if let _ = font?.fontDescriptor.object(forKey: UIFontDescriptorTextStyleAttribute) as? UIFontTextStyle {
            font = UIFont.preferredFont(forTextStyle: size.textStyle)
        }
        frame.size.height = size.height
    }
    
    @objc func onEditingChange(field: UITextField) {
        guard field.text != "" else {
            validationType = nil
            return
        }
        if let messages = validationMessages {
            if messages.count > 0 {
                if isEditing {
                    validationType = TextFieldType.warning
                } else {
                    validationType = TextFieldType.danger
                }
            } else {
                validationType = TextFieldType.success
            }
        } else {
            validationType = nil
        }
        
        updateBorder()
    }
    
    var validationMessages : [String]? {
        guard let validations = validations else { return nil }
        var messages = [String]()
        for validation in validations {
            if NSPredicate(format: "SELF MATCHES %@", validation.regex).evaluate(with: text) {
                // field is valid
            } else {
                messages.append(validation.message)
            }
        }
        return messages
    }
}

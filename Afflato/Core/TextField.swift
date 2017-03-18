//
//  TextField.swift
//  Afflato
//
//  Created by Matteo Gavagnin on 10/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit

public class TextField: UITextField {
    let imagePadding = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 0)
    
    var validations : [Validation]?
    var validationType : TextFieldType?
    
    var leftImage : UIImage? {
        didSet {
            if leftImage != nil {
                leftViewMode = .always
            } else {
                leftViewMode = .never
            }
        }
    }

    var rightImage : UIImage? {
        didSet {
            if rightImage != nil {
                rightViewMode = .always
            } else {
                rightViewMode = .never
            }
        }
    }
    
    var imageSize : CGSize {
        return CGSize(width: bounds.size.height - imagePadding.top - imagePadding.bottom, height: bounds.size.height - imagePadding.top - imagePadding.bottom)
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
    
    public var size : Size = .large {
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
    
    public override var intrinsicContentSize: CGSize {
        var intrinsicSize = super.intrinsicContentSize
        
        intrinsicSize.width = intrinsicSize.width + size.inset(style: style) * 2
        intrinsicSize.height = size.height
        layer.cornerRadius = style.cornerRadius(height: intrinsicSize.height)
        return intrinsicSize
    }
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return super.textRect(forBounds: bounds).insetBy(dx: size.inset(style: style), dy: 0)
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return super.editingRect(forBounds: bounds).insetBy(dx: size.inset(style: style), dy: 0)
    }
    
    public override func becomeFirstResponder() -> Bool {
        defer { layoutIfNeeded() }
        return super.becomeFirstResponder()
    }
    
    public override func resignFirstResponder() -> Bool {
        defer { layoutIfNeeded() }
        return super.resignFirstResponder()
    }
    
    public override var isSelected: Bool {
        didSet {
            layoutIfNeeded()
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
        
        layoutIfNeeded()
        
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
    
    public override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        var type = TextFieldType.normal
        
        if isEditing {
            type = TextFieldType.focused
        }
        
        if let validationType = validationType {
            type = validationType
        }
        
        let borderColorAnimation = CABasicAnimation(keyPath: "borderColor")
        borderColorAnimation.fromValue = layer.borderColor
        borderColorAnimation.toValue = type.borderColor.cgColor
        layer.borderColor = type.borderColor.cgColor
        
        let borderWidthAnimation = CABasicAnimation(keyPath: "borderWidth")
        borderWidthAnimation.fromValue = layer.borderWidth
        borderWidthAnimation.toValue = type.borderWidth
        layer.borderWidth = type.borderWidth
        
        let cornerRadiusAnimation = CABasicAnimation(keyPath: "cornerRadius")
        cornerRadiusAnimation.fromValue = layer.cornerRadius
        cornerRadiusAnimation.toValue = style.cornerRadius(height: bounds.height)
        layer.cornerRadius = style.cornerRadius(height: bounds.height)
        
        let borderAnimationGroup = CAAnimationGroup()
        borderAnimationGroup.animations = [borderColorAnimation, borderWidthAnimation, cornerRadiusAnimation]
        borderAnimationGroup.duration = 0.25
        borderAnimationGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        layer.add(borderAnimationGroup, forKey: "border width and color, corner radius")
        
        textColor = type.titleColor
        tintColor = type.borderColor
        
        if let _ = font?.fontDescriptor.object(forKey: UIFontDescriptorTextStyleAttribute) as? UIFontTextStyle {
            font = UIFont.preferredFont(forTextStyle: size.textStyle)
        }
        frame.size.height = size.height

        if (leftImage != nil) {
            let leftContainer = UIView(frame: CGRect(x: 0, y: 0, width: imageSize.width + imagePadding.right, height: imageSize.height))
            leftContainer.backgroundColor = .clear
            let leftImageView = UIImageView(frame: CGRect(x: imagePadding.left, y: 0, width: imageSize.width, height: imageSize.height))
            leftImageView.image = leftImage
            leftImageView.contentMode = .scaleAspectFit
            leftImageView.tintColor = type.borderColor
            leftContainer.addSubview(leftImageView)
            leftView = leftContainer
        } else {
            leftView = nil
        }
        
        if (rightImage != nil) {
            let rightContainer = UIView(frame: CGRect(x: 0, y: 0, width: imageSize.width + imagePadding.left, height: imageSize.height))
            rightContainer.backgroundColor = .clear
            let rightImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
            rightImageView.image = rightImage
            rightImageView.contentMode = .scaleAspectFit
            rightImageView.tintColor = type.borderColor
            rightContainer.addSubview(rightImageView)
            rightView = rightContainer
        } else {
            rightView = nil
        }
    }
    
    @objc func onEditingChange(field: UITextField) {
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
        layoutIfNeeded()
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

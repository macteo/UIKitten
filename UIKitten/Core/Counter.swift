//
//  Counter.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 30/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit

public class Counter : UIView, Alignable {
    
    // MARK: Alignable protocol
    
    public var width: Width? = .container(ratio: 1)
    public var height: Height? = .width(ratio: 0.25)
    public var padding : Int = 0
    public var align : Align? = [.middle, .center]
    
    // MARK: View Lifecycle
    
    public var value : Int? = 0 {
        didSet {
            if let value = value {
                valueLabel.text = "\(value)"
            } else {
                valueLabel.text = "-"
            }
        }
    }
    
    public var valueString : String? {
        didSet {
            if let value = valueString {
                valueLabel.text = value
            } else {
                valueLabel.text = ""
            }
        }
    }
    
    // TODO: expose a number formatter that can be used to format the value with a string
    // TODO: animate the value when updates
    
    public var caption: String? {
        didSet {
            if let caption = caption {
                captionLabel.text = caption
            } else {
                captionLabel.text = nil
            }
        }
    }
    
    public var image : UIImage? {
        didSet {
            // TODO: show or hide left container view
            imageView.image = image
        }
    }
    
    public var color : UIColor? = .warning {
        didSet {
            imageContainer.backgroundColor = color
        }
    }
    
    let imageContainer = UIView()
    let imageView = UIImageView()
    
    let valueLabel = Label()
    var valueHeight : NSLayoutConstraint?
    
    let captionLabel = Label()
    var captionHeight : NSLayoutConstraint?

    let contentView = UIView()
    
    override public required init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // FIXME: this doesn't work for some reason
    public convenience init(value: Int?, caption: String?) {
        let frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        self.init(frame: frame)
        self.value = value
        self.caption = caption
        commonInit()
    }
    
    func commonInit() {
        // TODO: take from theme
        cornerRadius = 4
        layer.masksToBounds = true
        
        let imageRatio : CGFloat = 0.5
        
        color = .warning
        
        imageContainer.frame = CGRect(x: 0, y: 0, width: bounds.size.width * 0.4, height: bounds.size.height)
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageContainer)
        
        addConstraint(NSLayoutConstraint(item: imageContainer, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageContainer, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageContainer, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageContainer, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.4, constant: 0))
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame = CGRect(x: 0, y: 0, width: bounds.size.height * imageRatio, height: bounds.size.height * imageRatio)
        imageView.contentMode = .scaleAspectFit
        
        // TODO: use theme
        imageView.tintColor = .white
        
        imageContainer.addSubview(imageView)
        imageContainer.addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: imageContainer, attribute: .centerX, multiplier: 1, constant: 0))
        imageContainer.addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: imageContainer, attribute: .centerY, multiplier: 1, constant: 0))
        imageContainer.addConstraint(NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .lessThanOrEqual, toItem: imageContainer, attribute: .width, multiplier: imageRatio, constant: 0))
        imageView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: imageView, attribute: .height, multiplier: 1, constant: 0))
        
        // TODO: grab background color from the theme
        backgroundColor = .white
        contentView.frame = bounds
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        
        addConstraint(NSLayoutConstraint(item: contentView, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: contentView, attribute: .leading, relatedBy: .equal, toItem: imageContainer, attribute: .trailing, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: contentView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        
        valueLabel.frame = CGRect(x: 0, y: 0, width: contentView.bounds.size.width, height: contentView.bounds.size.height / 2)
        valueLabel.contentAlign = .bottom
        valueLabel.textAlignment = .center
        valueLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        // TODO: use theme
        valueLabel.textColor = .tableGray
        contentView.addSubview(valueLabel)
        
        contentView.addConstraint(NSLayoutConstraint(item: valueLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: valueLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: valueLabel, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: valueLabel, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0))
        
        captionLabel.frame = CGRect(x: 0, y: contentView.bounds.size.height / 2, width: contentView.bounds.size.width, height: contentView.bounds.size.height / 2)
        captionLabel.contentAlign = .top
        captionLabel.textAlignment = .center
        captionLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        captionLabel.translatesAutoresizingMaskIntoConstraints = false
        // TODO: use theme
        captionLabel.textColor = .tableGray
        contentView.addSubview(captionLabel)
        contentView.addConstraint(NSLayoutConstraint(item: captionLabel, attribute: .top, relatedBy: .equal, toItem: valueLabel, attribute: .bottom, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: captionLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: captionLabel, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: captionLabel, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0))
        
        if #available(iOS 10, *) { } else {
            // Only for iOS 9
            NotificationCenter.default.addObserver(self, selector: #selector(self.contentSizeDidChange(notification:)), name: Notification.Name.UIContentSizeCategoryDidChange, object: nil)
        }
    }
    
    func contentSizeDidChange(notification: Notification) {
        traitCollectionDidChange(nil)
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if let valueStyle = valueLabel.font.fontDescriptor.object(forKey: UIFontDescriptorTextStyleAttribute) as? UIFontTextStyle {
            valueLabel.font = UIFont.preferredFont(forTextStyle: valueStyle)
        }
        
        if let captionStyle = captionLabel.font.fontDescriptor.object(forKey: UIFontDescriptorTextStyleAttribute) as? UIFontTextStyle {
            captionLabel.font = UIFont.preferredFont(forTextStyle: captionStyle)
        }
    }
    
    public func add(to view: UIView) -> UIView {
        view.addSubview(self)
        return self
    }
    
    override public func didMoveToSuperview() {
        super.didMoveToSuperview()
        configureAlignConstraints()
    }
}

//
//  BaseCollectionViewCell.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 20/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit

protocol BaseCollectionViewCellDelegate {
    func redraw(cell: BaseCollectionViewCell)
}

open class BaseCollectionViewCell: UICollectionViewCell {
    
    public var padding = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10) {
        didSet {
            layoutIfNeeded()
        }
    }
    
    let separator = UIView()
    let accessoryView = UIView()
    let accessoryViewSize : CGFloat = 20
    var accessoryViewWidth : NSLayoutConstraint?
    var accessoryViewTrailingMargin : NSLayoutConstraint?
    var accessoryViewCenterYConstraint : NSLayoutConstraint?
    let minimumCellHeight : CGFloat = 44
    
    var containedView : UIView? {
        didSet {
            if let containedView = containedView {
                    customView.addSubview(containedView)
                    containedView.configureAlignConstraints()
            } else {
                if oldValue?.superview == customView {
                    oldValue?.removeFromSuperview()
                }
            }
        }
    }
    
    var delegate : BaseCollectionViewCellDelegate?
    
    var contentViewWidth : NSLayoutConstraint?
    
    let mainView = UIView()
    
    let footerView = UIView()
    var footerFixedHeightConstraint : NSLayoutConstraint?
    var footerHeight : CGFloat = 0

    let customView = UIView()

    public var footerIsVisible : Bool = false {
        didSet {
            footerFixedHeightConstraint?.isActive = !footerIsVisible
            delegate?.redraw(cell: self)
        }
    }
    
    public var separatorIsVisible : Bool = true {
        didSet {
            separator.isHidden = !separatorIsVisible
        }
    }
    
    public var accessoryViewIsVisible : Bool = false {
        didSet {
            layoutIfNeeded()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        tintColor = .tableGray
        if accessoryView.superview != nil {
            accessoryView.removeFromSuperview()
        }
        
        if let contentViewWidth = contentViewWidth  {
            contentView.removeConstraint(contentViewWidth)
        }
        
        footerView.accessibilityIdentifier = "CellFooter"
        contentView.accessibilityIdentifier = "CellContentView"
        accessibilityIdentifier = "BaseCollectionViewCell"
        customView.accessibilityIdentifier = "CellCustomView"
        
        contentViewWidth = NSLayoutConstraint(item: contentView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: desiredSize.width)
        contentViewWidth?.priority = 750
        contentView.addConstraint(contentViewWidth!)
        
        accessoryView.frame = CGRect(x: bounds.size.width - accessoryViewSize - padding.right, y: (bounds.size.height - accessoryViewSize) / 2, width: accessoryViewSize, height: accessoryViewSize)
        accessoryView.translatesAutoresizingMaskIntoConstraints = false
        accessoryView.clipsToBounds = true
        accessoryView.accessibilityIdentifier = "CellAccessoryView"
        contentView.addSubview(accessoryView)
        
        accessoryViewWidth = NSLayoutConstraint(item: accessoryView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: accessoryViewSize)
        contentView.addConstraint(accessoryViewWidth!)
        
        accessoryViewTrailingMargin = NSLayoutConstraint(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: accessoryView, attribute: .trailing, multiplier: 1, constant: padding.right)
        contentView.addConstraint(accessoryViewTrailingMargin!)
        contentView.addConstraint(NSLayoutConstraint(item: accessoryView, attribute: .height, relatedBy: .equal, toItem: accessoryView, attribute: .width, multiplier: 1, constant: 1))
        
        if separator.superview != nil {
            separator.removeFromSuperview()
        }
        separator.accessibilityIdentifier = "CellSeparator"
        separator.frame = CGRect(x: padding.left, y: bounds.size.height - 1.0 / UIScreen.main.scale, width: bounds.size.width - padding.left, height: 1.0 / UIScreen.main.scale)
        separator.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        separator.backgroundColor = .defaultTableSelected
        contentView.addSubview(separator)
        
        let accessoryImageView = UIImageView(frame: accessoryView.bounds)
        accessoryImageView.tintColor = tintColor
        
        if let disclosureImage = UIImage(named: "disclosureIndicator", in: Bundle.init(for: SubtitleCollectionViewCell.self), compatibleWith: nil) {
            let templateImage = disclosureImage.withRenderingMode(.alwaysTemplate)
            accessoryImageView.image = templateImage
        }
        
        accessoryImageView.contentMode = .scaleAspectFit
        accessoryView.addSubview(accessoryImageView)
        
        if mainView.superview != nil {
            mainView.removeFromSuperview()
        }
        
        mainView.frame = CGRect(x: 0, y: 0, width: contentView.bounds.size.width - accessoryView.frame.size.width, height: contentView.bounds.size.height)
        mainView.backgroundColor = .clear
        mainView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mainView)
        
        contentView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .leading, relatedBy: .equal, toItem: mainView, attribute: .leading, multiplier: 1, constant: -padding.left))
        contentView.addConstraint(NSLayoutConstraint(item: mainView, attribute: .trailing, relatedBy: .equal, toItem: accessoryView, attribute: .leading, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .top, relatedBy: .equal, toItem: mainView, attribute: .top, multiplier: 1, constant: -padding.top))
        
        accessoryViewCenterYConstraint = NSLayoutConstraint(item: accessoryView, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0)
        contentView.addConstraint(accessoryViewCenterYConstraint!)
        
        if customView.superview != nil {
            customView.removeFromSuperview()
        }
        
        customView.frame = CGRect(x: 0, y: minimumCellHeight, width: bounds.size.width, height: 0)
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.backgroundColor = .clear
        contentView.addSubview(customView)
        
        contentView.addConstraint(NSLayoutConstraint(item: customView, attribute: .top, relatedBy: .equal, toItem: mainView, attribute: .bottom, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: customView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: padding.left))
        contentView.addConstraint(NSLayoutConstraint(item: customView, attribute: .trailing, relatedBy: .equal, toItem: accessoryView, attribute: .leading, multiplier: 1, constant: 0))
        
        if footerView.superview != nil {
            footerView.removeFromSuperview()
        }
        
        footerView.frame = CGRect(x: 0, y: minimumCellHeight, width: bounds.size.width, height: 60)
        footerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(footerView)
        
        contentView.addConstraint(NSLayoutConstraint(item: footerView, attribute: .top, relatedBy: .equal, toItem: customView, attribute: .bottom, multiplier: 1, constant: padding.bottom))
        contentView.addConstraint(NSLayoutConstraint(item: footerView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: footerView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: footerView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0))
        
        if footerFixedHeightConstraint != nil {
            contentView.removeConstraint(footerFixedHeightConstraint!)
            footerFixedHeightConstraint = nil
        }
        
        // This is the footer height constraint so it will be hidden
        footerFixedHeightConstraint = NSLayoutConstraint(item: footerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: footerHeight)
        contentView.addConstraint(footerFixedHeightConstraint!)
        
        footerFixedHeightConstraint?.isActive = !footerIsVisible
        
        if #available(iOS 10, *) { } else {
            // Needed only on iOS 9
            NotificationCenter.default.addObserver(self, selector: #selector(self.contentSizeDidChange(notification:)), name: Notification.Name.UIContentSizeCategoryDidChange, object: nil)
        }
    }
    
    open override var isSelected: Bool {
        didSet {
            UIView.animate(withDuration: 0.15, animations: {
                if self.isSelected {
                    self.backgroundColor = .defaultTableSelected
                    self.separator.backgroundColor = .clear
                    // self.footerIsVisible = true
                } else {
                    self.backgroundColor = .white
                    self.separator.backgroundColor = .defaultTableSelected
                    // self.footerIsVisible = false
                }
            })
        }
    }
    
    open override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        if accessoryViewIsVisible {
            accessoryViewWidth?.constant = accessoryViewSize
            accessoryViewTrailingMargin?.constant = padding.right
        } else {
            accessoryViewWidth?.constant = 0
            accessoryViewTrailingMargin?.constant = padding.right
        }
        
        accessoryViewCenterYConstraint?.constant = (mainView.bounds.height + customView.bounds.height + padding.top + padding.bottom) / 2
        
        isHeightCalculated = false
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func contentSizeDidChange(notification: Notification) {
        traitCollectionDidChange(nil)
    }
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        layoutIfNeeded()
    }
    
    override open func prepareForReuse() {
        super.prepareForReuse()
        delegate = nil
        isHeightCalculated = false
        containedView = nil
        layoutIfNeeded()
    }
    
    //forces the system to do one layout pass
    var isHeightCalculated: Bool = false
    
    var desiredSize = CGSize(width: 2048, height: 320) {
        didSet {
            // Limiting the cell width
            contentViewWidth?.constant = desiredSize.width
        }
    }
    
    override open func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        if !isHeightCalculated {
            setNeedsLayout()
            layoutIfNeeded()
            
            let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
            var newFrame = layoutAttributes.frame
            newFrame.size.width = CGFloat(floorf(Float(size.width)))
            
            newFrame.size.height = CGFloat(ceilf(Float(size.height)))
            layoutAttributes.frame = newFrame
            isHeightCalculated = true
        }
        return layoutAttributes
    }
}

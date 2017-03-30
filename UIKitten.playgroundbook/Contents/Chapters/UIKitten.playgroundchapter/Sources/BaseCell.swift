//
//  BaseCell.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 20/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit

open class BaseCell: UICollectionViewCell, Cell {
    
    public var minHeight : CGFloat = 44 {
        didSet {
            minimumCellHeightConstraint?.constant = minHeight
        }
    }
    
    public var padding = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 4) {
        didSet {
            // Changing padding at runtime is a good idea?
        }
    }
    
    let separator = UIView()
    let accessoryView = UIView()
    let accessoryViewSize : CGFloat = 20
    var accessoryViewWidth : NSLayoutConstraint?
    var accessoryViewTrailingMargin : NSLayoutConstraint?
    var accessoryViewCenterYConstraint : NSLayoutConstraint?
    
    var mainViewCenterYConstraint : NSLayoutConstraint?
    
    var separatorLeadingMargin : NSLayoutConstraint?
    var separatorTrailingMargin : NSLayoutConstraint?
    
    var minimumCellHeightConstraint : NSLayoutConstraint?
    
    public var containedView : UIView? {
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
    
    public var separatorInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0) {
        didSet {
            separatorLeadingMargin?.constant = separatorInset.left
            separatorTrailingMargin?.constant = separatorInset.right
        }
    }
    
    public var delegate : CellDelegate?
    
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
            if accessoryViewIsVisible {
                accessoryViewWidth?.constant = accessoryViewSize
                accessoryViewTrailingMargin?.constant = padding.right
            } else {
                accessoryViewWidth?.constant = 0
                accessoryViewTrailingMargin?.constant = padding.right
            }
            
            accessoryViewCenterYConstraint?.constant = (mainView.bounds.height + customView.bounds.height + padding.top + padding.bottom) / 2
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
        tintColor = .tableGray
        
        if accessoryView.superview != nil {
            accessoryView.removeFromSuperview()
        }
        
        if let contentViewWidth = contentViewWidth  {
            contentView.removeConstraint(contentViewWidth)
        }
        
        minimumCellHeightConstraint = NSLayoutConstraint(item: contentView, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: minHeight)
        contentView.addConstraint(minimumCellHeightConstraint!)
        
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
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        separator.backgroundColor = .defaultTableSelected
        contentView.addSubview(separator)
        
        separatorLeadingMargin = NSLayoutConstraint(item: separator, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: separatorInset.left)
        contentView.addConstraint(separatorLeadingMargin!)
        
        separatorTrailingMargin = NSLayoutConstraint(item: separator, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -separatorInset.right)
        contentView.addConstraint(separatorTrailingMargin!)
        
        contentView.addConstraint(NSLayoutConstraint(item: separator, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: separatorInset.bottom))
        separator.addConstraint(NSLayoutConstraint(item: separator, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1.0 / UIScreen.main.scale))
        
        let accessoryImageView = UIImageView(frame: accessoryView.bounds)
        accessoryImageView.tintColor = tintColor
        
        if let disclosureImage = UIImage(named: "disclosureIndicator", in: Bundle.init(for: BaseCell.self), compatibleWith: nil) {
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
        contentView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .top, relatedBy: .lessThanOrEqual, toItem: mainView, attribute: .top, multiplier: 1, constant: -padding.top))
        
        mainViewCenterYConstraint = NSLayoutConstraint(item: contentView, attribute: .centerY, relatedBy: .equal, toItem: mainView, attribute: .centerY, multiplier: 1, constant: 0)
        mainViewCenterYConstraint!.priority = 1
        
        contentView.addConstraint(mainViewCenterYConstraint!)
        
        accessoryViewCenterYConstraint = NSLayoutConstraint(item: accessoryView, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0)
        contentView.addConstraint(accessoryViewCenterYConstraint!)
        
        if customView.superview != nil {
            customView.removeFromSuperview()
        }
        
        customView.frame = CGRect(x: 0, y: minHeight, width: bounds.size.width, height: 0)
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.backgroundColor = .clear
        contentView.addSubview(customView)
        
        contentView.addConstraint(NSLayoutConstraint(item: customView, attribute: .top, relatedBy: .equal, toItem: mainView, attribute: .bottom, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: customView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: padding.left))
        contentView.addConstraint(NSLayoutConstraint(item: customView, attribute: .trailing, relatedBy: .equal, toItem: accessoryView, attribute: .leading, multiplier: 1, constant: 0))
        
        if footerView.superview != nil {
            footerView.removeFromSuperview()
        }
        
        footerView.frame = CGRect(x: 0, y: minHeight, width: bounds.size.width, height: 60)
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
        
        accessoryViewIsVisible = false
        
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func contentSizeDidChange(notification: Notification) {
        traitCollectionDidChange(nil)
    }
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
    }
    
    override open func prepareForReuse() {
        super.prepareForReuse()
        delegate = nil
        isHeightCalculated = false
        containedView = nil
        accessoryViewIsVisible = false
    }
    
    //forces the system to do one layout pass
    public var isHeightCalculated: Bool = false
    
    public var desiredSize = CGSize(width: 2048, height: 320) {
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
    
    public func populate(item: ListItem, width: CGFloat) {
        if let _ = item.itemAction() {
            accessoryViewIsVisible = true
        } else {
            accessoryViewIsVisible = false
        }

        desiredSize = CGSize(width: width, height: 44)
        
        if var itemView = item.itemView() as? Alignable {
            if itemView.align == nil {
                itemView.align = [.top, .left]
            }
        }
        
        containedView = item.itemView()
        
        layoutIfNeeded()
    }
}

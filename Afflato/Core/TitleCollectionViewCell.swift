//
//  DefaultCollectionViewCell.swift
//  Afflato
//
//  Created by Matteo Gavagnin on 13/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit

public class TitleCollectionViewCell: UICollectionViewCell {
    let titleLabel = UILabel()
    var titleHeight : NSLayoutConstraint?
    var titleTrailingMargin : NSLayoutConstraint?
    var titleLeadingMargin : NSLayoutConstraint?
    
    let padding = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
    let separator = UIView()
    let accessoryView = UIView()
    let accessoryViewSize : CGFloat = 0 // 20 is visible
    var accessoryViewWidth : NSLayoutConstraint?
    var accessoryViewTrailingMargin : NSLayoutConstraint?
    let minimumCellHeight : CGFloat = 44
    
    public var separatorIsVisible : Bool = true {
        didSet {
            separator.isHidden = !separatorIsVisible
        }
    }
    
    public var accessoryViewIsVisible : Bool = true {
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
        
        accessoryView.frame = CGRect(x: bounds.size.width - accessoryViewSize - padding.right, y: (bounds.size.height - accessoryViewSize) / 2, width: accessoryViewSize, height: accessoryViewSize)
        accessoryView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(accessoryView)
        
        accessoryViewWidth = NSLayoutConstraint(item: accessoryView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: accessoryViewSize) // TODO: change it if it's visible or not
        addConstraint(accessoryViewWidth!)
        
        addConstraint(NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: accessoryView, attribute: .centerY, multiplier: 1, constant: 0))
        accessoryViewTrailingMargin = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: accessoryView, attribute: .trailing, multiplier: 1, constant: padding.right)
        addConstraint(accessoryViewTrailingMargin!)
        addConstraint(NSLayoutConstraint(item: accessoryView, attribute: .height, relatedBy: .equal, toItem: accessoryView, attribute: .width, multiplier: 1, constant: 1))
        
        if titleLabel.superview != nil {
            titleLabel.removeFromSuperview()
        }
        titleLabel.frame = bounds.insetBy(dx: padding.left, dy: padding.top)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.backgroundColor = .clear
        titleLabel.numberOfLines = 0
        addSubview(titleLabel)
        
        addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .top, multiplier: 1, constant: -padding.top))
        addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: padding.bottom))
        titleTrailingMargin = NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: accessoryView, attribute: .leading, multiplier: 1, constant: -padding.right)
        addConstraint(titleTrailingMargin!)
        
        titleLeadingMargin = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: titleLabel, attribute: .leading, multiplier: 1, constant: -padding.left)
        addConstraint(titleLeadingMargin!)
        
        titleHeight = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 12)
        // titleHeight?.priority = 750
        addConstraint(titleHeight!)
        
        if separator.superview != nil {
            separator.removeFromSuperview()
        }
        separator.frame = CGRect(x: padding.left, y: bounds.size.height - 1.0 / UIScreen.main.scale, width: bounds.size.width - padding.left, height: 1.0 / UIScreen.main.scale)
        separator.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        separator.backgroundColor = .defaultTableSelected
        addSubview(separator)
        
        let accessoryImageView = UIImageView(frame: accessoryView.bounds)
        accessoryImageView.tintColor = tintColor
        
        if let disclosureImage = UIImage(named: "disclosureIndicator", in: Bundle.init(for: TitleCollectionViewCell.self), compatibleWith: nil) {
            let templateImage = disclosureImage.withRenderingMode(.alwaysTemplate)
            accessoryImageView.image = templateImage
        }
        
        accessoryImageView.contentMode = .scaleAspectFit
        accessoryView.addSubview(accessoryImageView)
        
        // TODO: support cell size like buttons
        titleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        
        if #available(iOS 10, *) { } else {
            // Only for iOS 8 and 9
            NotificationCenter.default.addObserver(self, selector: #selector(self.contentSizeDidChange(notification:)), name: Notification.Name.UIContentSizeCategoryDidChange, object: nil)
        }
    }
    
    public override var isSelected: Bool {
        didSet {
            UIView.animate(withDuration: 0.15, animations: {
                if self.isSelected {
                    self.backgroundColor = .defaultTableSelected
                    self.separator.backgroundColor = .clear
                } else {
                    self.backgroundColor = .white
                    self.separator.backgroundColor = .defaultTableSelected
                }
            })
        }
    }
    
    public override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        if accessoryViewIsVisible {
            accessoryViewWidth?.constant = accessoryViewSize
            accessoryViewTrailingMargin?.constant = padding.right
        } else {
            accessoryViewWidth?.constant = 0
            accessoryViewTrailingMargin?.constant = 0
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func contentSizeDidChange(notification: Notification) {
        traitCollectionDidChange(nil)
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if let textStyle = titleLabel.font.fontDescriptor.object(forKey: UIFontDescriptorTextStyleAttribute) as? UIFontTextStyle {
            titleLabel.font = UIFont.preferredFont(forTextStyle: textStyle)
        }
        layoutIfNeeded()
    }
    
    func set(title: String?) {
        titleLabel.text = title
        
        // Calculate title height
        guard let titleHeight = titleHeight else { return }
        guard let accessoryViewWidth = accessoryViewWidth else { return }
        guard let titleLeadingMargin = titleLeadingMargin else { return }
        let width : CGFloat = bounds.size.width - padding.left - padding.right - accessoryViewWidth.constant - titleLeadingMargin.constant
        
        let expectedHeight = titleLabel.sizeThatFits(CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)).height
        titleHeight.priority = 750
        // Minimum cell height is 44
        titleHeight.constant = max(floor(expectedHeight + 1), minimumCellHeight)
        
        setNeedsLayout()
    }
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        titleHeight?.constant = 12
    }
}

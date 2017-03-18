//
//  SubtitleCollectionViewCell.swift
//  Afflato
//
//  Created by Matteo Gavagnin on 17/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit

public class SubtitleCollectionViewCell: UICollectionViewCell {
    let titleLabel = UILabel()
    var titleHeight : NSLayoutConstraint?
    var titleTrailingMargin : NSLayoutConstraint?
    var titleLeadingMargin : NSLayoutConstraint?
    
    let subtitleLabel = UILabel()
    var subtitleHeight : NSLayoutConstraint?
    var subtitleTrailingMargin : NSLayoutConstraint?
    var subtitleLeadingMargin : NSLayoutConstraint?
    
    let padding = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
    let separator = UIView()
    let accessoryView = UIView()
    let accessoryViewSize : CGFloat = 20
    var accessoryViewWidth : NSLayoutConstraint?
    var accessoryViewTrailingMargin : NSLayoutConstraint?
    let minimumCellHeight : CGFloat = 44
    
    var contentViewWidth : NSLayoutConstraint?
    
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
        
        contentViewWidth = NSLayoutConstraint(item: contentView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: desiredSize.width)
        contentView.addConstraint(contentViewWidth!)
        
        accessoryView.frame = CGRect(x: bounds.size.width - accessoryViewSize - padding.right, y: (bounds.size.height - accessoryViewSize) / 2, width: accessoryViewSize, height: accessoryViewSize)
        accessoryView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(accessoryView)
        
        accessoryViewWidth = NSLayoutConstraint(item: accessoryView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: accessoryViewSize)
        contentView.addConstraint(accessoryViewWidth!)
        
        contentView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .centerY, relatedBy: .equal, toItem: accessoryView, attribute: .centerY, multiplier: 1, constant: 0))
        accessoryViewTrailingMargin = NSLayoutConstraint(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: accessoryView, attribute: .trailing, multiplier: 1, constant: padding.right)
        contentView.addConstraint(accessoryViewTrailingMargin!)
        contentView.addConstraint(NSLayoutConstraint(item: accessoryView, attribute: .height, relatedBy: .equal, toItem: accessoryView, attribute: .width, multiplier: 1, constant: 1))
        
        if titleLabel.superview != nil {
            titleLabel.removeFromSuperview()
        }
        titleLabel.frame = bounds.insetBy(dx: padding.left, dy: padding.top)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.backgroundColor = .clear
        titleLabel.numberOfLines = 0
        contentView.addSubview(titleLabel)
        
        if subtitleLabel.superview != nil {
            subtitleLabel.removeFromSuperview()
        }
        subtitleLabel.frame = bounds.insetBy(dx: padding.left, dy: padding.top)
        subtitleLabel.bounds.size.height = 0
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.backgroundColor = .clear
        subtitleLabel.numberOfLines = 0
        contentView.addSubview(subtitleLabel)
        
        contentView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .top, multiplier: 1, constant: -padding.top))
        contentView.addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 0)) // TODO: add a padding
        titleTrailingMargin = NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: accessoryView, attribute: .leading, multiplier: 1, constant: -padding.right)
        contentView.addConstraint(titleTrailingMargin!)
        
        titleLeadingMargin = NSLayoutConstraint(item: contentView, attribute: .leading, relatedBy: .equal, toItem: titleLabel, attribute: .leading, multiplier: 1, constant: -padding.left)
        contentView.addConstraint(titleLeadingMargin!)
        
        titleHeight = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 12)
        titleHeight?.priority = 750
        contentView.addConstraint(titleHeight!)
        
        contentView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: subtitleLabel, attribute: .bottom, multiplier: 1, constant: padding.bottom))
        subtitleTrailingMargin = NSLayoutConstraint(item: subtitleLabel, attribute: .trailing, relatedBy: .equal, toItem: accessoryView, attribute: .leading, multiplier: 1, constant: -padding.right)
        contentView.addConstraint(subtitleTrailingMargin!)
        
        subtitleLeadingMargin = NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: subtitleLabel, attribute: .leading, multiplier: 1, constant: 0)
        contentView.addConstraint(subtitleLeadingMargin!)
        
        subtitleHeight = NSLayoutConstraint(item: subtitleLabel, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        subtitleHeight?.priority = 750
        contentView.addConstraint(subtitleHeight!)
        
        if separator.superview != nil {
            separator.removeFromSuperview()
        }
        separator.frame = CGRect(x: padding.left, y: bounds.size.height - 1.0 / UIScreen.main.scale, width: bounds.size.width - padding.left, height: 1.0 / UIScreen.main.scale)
        separator.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        separator.backgroundColor = .defaultTableSelected
        contentView.addSubview(separator)
        
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
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        
        if #available(iOS 10, *) { } else {
            // Needed only on iOS 9
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
        
        // Calculate subtitle height
        guard let subtitleHeight = subtitleHeight else { return }
        guard let accessoryViewWidth = accessoryViewWidth else { return }
        guard let subtitleLeadingMargin = subtitleLeadingMargin else { return }
        let width : CGFloat = desiredSize.width - padding.left - padding.right - accessoryViewWidth.constant - subtitleLeadingMargin.constant
        
        subtitleLabel.preferredMaxLayoutWidth = width
        
        let expectedHeight = subtitleLabel.sizeThatFits(CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)).height
        subtitleHeight.priority = 750
        subtitleHeight.constant = ceil(expectedHeight)

        // Calculate title height
        guard let titleHeight = titleHeight else { return }
        guard let titleLeadingMargin = titleLeadingMargin else { return }
        let titleWidth : CGFloat = desiredSize.width - padding.left - padding.right - accessoryViewWidth.constant - titleLeadingMargin.constant
        
        let expectedTitleHeight = titleLabel.sizeThatFits(CGSize(width: titleWidth, height: CGFloat.greatestFiniteMagnitude)).height
        titleHeight.priority = 750
        
        titleLabel.preferredMaxLayoutWidth = titleWidth
        
        // Minimum cell height is 44
        if subtitleLabel.text == nil {
            titleHeight.constant = max(ceil(expectedTitleHeight), minimumCellHeight)
        } else {
            titleHeight.constant = ceil(expectedTitleHeight)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func contentSizeDidChange(notification: Notification) {
        traitCollectionDidChange(nil)
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if let titleStyle = titleLabel.font.fontDescriptor.object(forKey: UIFontDescriptorTextStyleAttribute) as? UIFontTextStyle {
            titleLabel.font = UIFont.preferredFont(forTextStyle: titleStyle)
        }
        
        if let subtitleStyle = subtitleLabel.font.fontDescriptor.object(forKey: UIFontDescriptorTextStyleAttribute) as? UIFontTextStyle {
            subtitleLabel.font = UIFont.preferredFont(forTextStyle: subtitleStyle)
        }
        
        layoutIfNeeded()
    }
    
    var title : String? {
        didSet {
            titleLabel.text = title
            layoutIfNeeded()
        }
    }
    
    var subtitle: String? {
        didSet {
            subtitleLabel.text = subtitle
            layoutIfNeeded()
        }
    }
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        subtitleLabel.text = nil
        titleHeight?.constant = 12
        subtitleHeight?.constant = 0
    }
    
    //forces the system to do one layout pass
    var isHeightCalculated: Bool = false
    
    var desiredSize = CGSize(width: 320, height: 100) {
        didSet {
            // Limiting the cell width
            contentViewWidth?.constant = desiredSize.width
        }
    }

    override public func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        //Exhibit A - We need to cache our calculation to prevent a crash.
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

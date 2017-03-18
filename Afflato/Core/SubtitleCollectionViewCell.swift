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
        
        accessoryView.frame = CGRect(x: bounds.size.width - accessoryViewSize - padding.right, y: (bounds.size.height - accessoryViewSize) / 2, width: accessoryViewSize, height: accessoryViewSize)
        accessoryView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(accessoryView)
        
        accessoryViewWidth = NSLayoutConstraint(item: accessoryView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: accessoryViewSize)
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
        
        if subtitleLabel.superview != nil {
            subtitleLabel.removeFromSuperview()
        }
        subtitleLabel.frame = bounds.insetBy(dx: padding.left, dy: padding.top)
        subtitleLabel.bounds.size.height = 0
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.backgroundColor = .clear
        subtitleLabel.numberOfLines = 0
        addSubview(subtitleLabel)
        
        addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .top, multiplier: 1, constant: -padding.top))
        addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 0)) // TODO: add a padding
        titleTrailingMargin = NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: accessoryView, attribute: .leading, multiplier: 1, constant: -padding.right)
        addConstraint(titleTrailingMargin!)
        
        titleLeadingMargin = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: titleLabel, attribute: .leading, multiplier: 1, constant: -padding.left)
        addConstraint(titleLeadingMargin!)
        
        titleHeight = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 12)
        titleHeight?.priority = 750
        addConstraint(titleHeight!)
        
        addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: subtitleLabel, attribute: .bottom, multiplier: 1, constant: padding.bottom))
        subtitleTrailingMargin = NSLayoutConstraint(item: subtitleLabel, attribute: .trailing, relatedBy: .equal, toItem: accessoryView, attribute: .leading, multiplier: 1, constant: -padding.right)
        addConstraint(subtitleTrailingMargin!)
        
        subtitleLeadingMargin = NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: subtitleLabel, attribute: .leading, multiplier: 1, constant: 0)
        addConstraint(subtitleLeadingMargin!)
        
        subtitleHeight = NSLayoutConstraint(item: subtitleLabel, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        subtitleHeight?.priority = 750
        addConstraint(subtitleHeight!)
        
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
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        
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
            
            // Calculate title height
            guard let titleHeight = titleHeight else { return }
            guard let accessoryViewWidth = accessoryViewWidth else { return }
            guard let titleLeadingMargin = titleLeadingMargin else { return }
            let width : CGFloat = bounds.size.width - padding.left - padding.right - accessoryViewWidth.constant - titleLeadingMargin.constant
            
            let expectedHeight = titleLabel.sizeThatFits(CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)).height
            titleHeight.priority = 750
            // Minimum cell height is 44
            if subtitleLabel.text == nil {
                titleHeight.constant = max(ceil(expectedHeight), minimumCellHeight)
            } else {
                titleHeight.constant = ceil(expectedHeight)
            }
            
            setNeedsLayout()
        }
    }
    
    var subtitle: String? {
        didSet {
            subtitleLabel.text = subtitle
            
            // Calculate title height
            guard let subtitleHeight = subtitleHeight else { return }
            guard let accessoryViewWidth = accessoryViewWidth else { return }
            guard let subtitleLeadingMargin = subtitleLeadingMargin else { return }
            let width : CGFloat = bounds.size.width - padding.left - padding.right - accessoryViewWidth.constant - subtitleLeadingMargin.constant
            
            let expectedHeight = subtitleLabel.sizeThatFits(CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)).height
            subtitleHeight.priority = 750
            subtitleHeight.constant = floor(expectedHeight + 1)
            
            setNeedsLayout()
        }
    }
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        subtitleLabel.text = nil
        titleHeight?.constant = 12
        subtitleHeight?.constant = 0
    }
}

//
//  SubtitleCell.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 17/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit

public class SubtitleCell: BaseCell {
    let titleLabel = UILabel()
    var titleHeight : NSLayoutConstraint?
    var titleLeadingMargin : NSLayoutConstraint?
    
    let subtitleLabel = UILabel()
    var subtitleHeight : NSLayoutConstraint?
    var subtitleLeadingMargin : NSLayoutConstraint?

    required public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    let thumbnailView = UIImageView()
    let thumbnailDefaultSize : CGFloat = 38 // Cell height - 4 top - 4 bottom
    
    var thumbnail : UIImage? {
        didSet {
            thumbnailView.image = thumbnail
            if let _ = thumbnail  {
                thumbnailViewSize = thumbnailDefaultSize
            } else {
                thumbnailViewSize = 0
            }
        }
    }
    
    var thumbnailViewSize : CGFloat = 0 {
        didSet {
            thumbnailViewWidth?.constant = thumbnailViewSize
            
            if thumbnailViewSize != 0 {
                titleLeadingMargin?.constant = -padding.left
            } else {
                titleLeadingMargin?.constant = 0
            }
        }
    }

    var thumbnailViewWidth : NSLayoutConstraint?
    var thumbnailViewLeadingMargin : NSLayoutConstraint?
    var thumbnailViewVerticalAlign : NSLayoutConstraint?
    
    public var thumbnailAlign : Align = .middle {
        didSet {
            if (thumbnailViewVerticalAlign != nil) {
                mainView.removeConstraint(thumbnailViewVerticalAlign!)
                thumbnailViewVerticalAlign = nil
            }
            
            if thumbnailAlign == .middle {
                thumbnailViewVerticalAlign = NSLayoutConstraint(item: mainView, attribute: .centerY, relatedBy: .equal, toItem: thumbnailView, attribute: .centerY, multiplier: 1, constant: 0)
            } else {
                thumbnailViewVerticalAlign = NSLayoutConstraint(item: thumbnailView, attribute: .top, relatedBy: .equal, toItem: mainView, attribute: .top, multiplier: 1, constant: padding.top)
            }
            
            mainView.addConstraint(thumbnailViewVerticalAlign!)
        }
    }

    override func commonInit() {
        super.commonInit()
        
        thumbnailView.contentMode = .scaleAspectFit
        
        if titleLabel.superview != nil {
            titleLabel.removeFromSuperview()
        }
        titleLabel.frame = bounds.insetBy(dx: padding.left, dy: padding.top)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.backgroundColor = .clear
        titleLabel.numberOfLines = 0
        titleLabel.accessibilityIdentifier = "CellTitleLabel"
        mainView.addSubview(titleLabel)
        
        if subtitleLabel.superview != nil {
            subtitleLabel.removeFromSuperview()
        }
        subtitleLabel.frame = bounds.insetBy(dx: padding.left, dy: padding.top)
        subtitleLabel.bounds.size.height = 0
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.backgroundColor = .clear
        subtitleLabel.numberOfLines = 0
        titleLabel.accessibilityIdentifier = "CellTitleLabel"
        mainView.addSubview(subtitleLabel)
        
        mainView.addConstraint(NSLayoutConstraint(item: mainView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .top, multiplier: 1, constant: 0))
        mainView.addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 0))
        mainView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: mainView, attribute: .trailing, multiplier: 1, constant: 0))
        
        titleHeight = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 12)
        titleHeight?.priority = .defaultHigh
        mainView.addConstraint(titleHeight!)
        
        mainView.addConstraint(NSLayoutConstraint(item: mainView, attribute: .bottom, relatedBy: .equal, toItem: subtitleLabel, attribute: .bottom, multiplier: 1, constant: 0))
        mainView.addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .trailing, relatedBy: .equal, toItem: mainView, attribute: .trailing, multiplier: 1, constant: 0))
        
        subtitleLeadingMargin = NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: subtitleLabel, attribute: .leading, multiplier: 1, constant: 0)
        mainView.addConstraint(subtitleLeadingMargin!)
        
        subtitleHeight = NSLayoutConstraint(item: subtitleLabel, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        subtitleHeight?.priority = .defaultHigh
        mainView.addConstraint(subtitleHeight!)
        
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        
        if thumbnailView.superview != nil {
            thumbnailView.removeFromSuperview()
        }
        
        thumbnailView.frame = CGRect(x: padding.left, y: padding.top, width: thumbnailViewSize, height: thumbnailViewSize)
        thumbnailView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailView.accessibilityIdentifier = "CellThumbnailView"
        mainView.addSubview(thumbnailView)
        
        thumbnailViewWidth = NSLayoutConstraint(item: thumbnailView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: thumbnailViewSize)
        mainView.addConstraint(thumbnailViewWidth!)
        
        thumbnailViewLeadingMargin = NSLayoutConstraint(item: mainView, attribute: .leading, relatedBy: .equal, toItem: thumbnailView, attribute: .leading, multiplier: 1, constant: 0)
        mainView.addConstraint(thumbnailViewLeadingMargin!)
        mainView.addConstraint(NSLayoutConstraint(item: thumbnailView, attribute: .height, relatedBy: .equal, toItem: thumbnailView, attribute: .width, multiplier: 1, constant: 1))
        
        titleLeadingMargin = NSLayoutConstraint(item: thumbnailView, attribute: .trailing, relatedBy: .equal, toItem: titleLabel, attribute: .leading, multiplier: 1, constant: -padding.left)
        mainView.addConstraint(titleLeadingMargin!)
        
        let emptyOrangeView = UIView(frame: CGRect(x: 0, y: 0, width: contentView.bounds.size.width, height: 10))
        emptyOrangeView.backgroundColor = .orange
        emptyOrangeView.translatesAutoresizingMaskIntoConstraints = false
        
        footerView.addSubview(emptyOrangeView)
        
        footerView.addConstraint(NSLayoutConstraint(item: footerView, attribute: .top, relatedBy: .equal, toItem: emptyOrangeView, attribute: .top, multiplier: 1, constant: 0))
        footerView.addConstraint(NSLayoutConstraint(item: footerView, attribute: .bottom, relatedBy: .equal, toItem: emptyOrangeView, attribute: .bottom, multiplier: 1, constant: 0))
        footerView.addConstraint(NSLayoutConstraint(item: footerView, attribute: .leading, relatedBy: .equal, toItem: emptyOrangeView, attribute: .leading, multiplier: 1, constant: 0))
        footerView.addConstraint(NSLayoutConstraint(item: footerView, attribute: .trailing, relatedBy: .equal, toItem: emptyOrangeView, attribute: .trailing, multiplier: 1, constant: 0))
        let emptyHeight = NSLayoutConstraint(item: emptyOrangeView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40)
        emptyHeight.priority = UILayoutPriority(rawValue: 650)
        footerView.addConstraint(emptyHeight)
        
        thumbnailViewSize = 0
        thumbnailAlign = .middle
    }

    public override func layoutIfNeeded() {
        super.layoutIfNeeded()
        adaptTitleAndSubtitleHeight()
    }
    
    func adaptTitleAndSubtitleHeight() {
        
        // Calculate subtitle height
        guard let subtitleHeight = subtitleHeight else { return }
        guard let accessoryViewWidth = accessoryViewWidth else { return }
        guard let titleLeadingMargin = titleLeadingMargin else { return }
        guard let thumbnailViewLeadingMargin = thumbnailViewLeadingMargin else { return }
        guard let thumbnailViewWidth = thumbnailViewWidth else { return }
        
        let width : CGFloat = floor(desiredSize.width - padding.left - padding.right - accessoryViewWidth.constant + titleLeadingMargin.constant + thumbnailViewLeadingMargin.constant - thumbnailViewWidth.constant)
        
        subtitleLabel.preferredMaxLayoutWidth = width
        
        let expectedHeight = subtitleLabel.sizeThatFits(CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)).height
        subtitleHeight.priority = .defaultHigh
        subtitleHeight.constant = ceil(expectedHeight)
        
        // Calculate title height
        guard let titleHeight = titleHeight else { return }
        
        let titleWidth : CGFloat = floor(desiredSize.width - padding.left - padding.right - accessoryViewWidth.constant + titleLeadingMargin.constant + thumbnailViewLeadingMargin.constant - thumbnailViewWidth.constant)
        
        let expectedTitleHeight = titleLabel.sizeThatFits(CGSize(width: titleWidth, height: CGFloat.greatestFiniteMagnitude)).height
        titleHeight.priority = .defaultHigh
        
        titleLabel.preferredMaxLayoutWidth = titleWidth
        titleHeight.constant = ceil(expectedTitleHeight)
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if let titleStyle = titleLabel.font.fontDescriptor.object(forKey: .textStyle) as? UIFontTextStyle {
            titleLabel.font = UIFont.preferredFont(forTextStyle: titleStyle)
        }
        
        if let subtitleStyle = subtitleLabel.font.fontDescriptor.object(forKey: .textStyle) as? UIFontTextStyle {
            subtitleLabel.font = UIFont.preferredFont(forTextStyle: subtitleStyle)
        }
        
        adaptTitleAndSubtitleHeight()
    }
    
    var title : String? {
        didSet {
            titleLabel.text = title
            adaptTitleAndSubtitleHeight()
        }
    }
    
    var subtitle: String? {
        didSet {
            subtitleLabel.text = subtitle
            adaptTitleAndSubtitleHeight()
        }
    }
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        subtitleLabel.text = nil
        titleHeight?.constant = 12
        subtitleHeight?.constant = 0
    }
    
    override public func populate(item: ListItem, width: CGFloat) {
        title = item.itemTitle()
        subtitle = item.itemSubtitle()
        thumbnail = item.itemImage()
        
        super.populate(item: item, width: width)
    }
}

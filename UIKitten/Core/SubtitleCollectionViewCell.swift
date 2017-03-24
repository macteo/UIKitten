//
//  SubtitleCollectionViewCell.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 17/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit

public class SubtitleCollectionViewCell: BaseCollectionViewCell {
    let titleLabel = UILabel()
    var titleHeight : NSLayoutConstraint?
    var titleLeadingMargin : NSLayoutConstraint?
    
    let subtitleLabel = UILabel()
    var subtitleHeight : NSLayoutConstraint?
    var subtitleLeadingMargin : NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func commonInit() {
        super.commonInit()
        
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
        
        titleLeadingMargin = NSLayoutConstraint(item: mainView, attribute: .leading, relatedBy: .equal, toItem: titleLabel, attribute: .leading, multiplier: 1, constant: 0)
        mainView.addConstraint(titleLeadingMargin!)
        
        titleHeight = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 12)
        titleHeight?.priority = 750
        mainView.addConstraint(titleHeight!)
        
        mainView.addConstraint(NSLayoutConstraint(item: mainView, attribute: .bottom, relatedBy: .equal, toItem: subtitleLabel, attribute: .bottom, multiplier: 1, constant: 0))
        mainView.addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .trailing, relatedBy: .equal, toItem: mainView, attribute: .trailing, multiplier: 1, constant: 0))
        
        subtitleLeadingMargin = NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: subtitleLabel, attribute: .leading, multiplier: 1, constant: 0)
        mainView.addConstraint(subtitleLeadingMargin!)
        
        subtitleHeight = NSLayoutConstraint(item: subtitleLabel, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        subtitleHeight?.priority = 750
        mainView.addConstraint(subtitleHeight!)
        
        // TODO: support cell size like buttons
        titleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
    }

    public override func layoutIfNeeded() {
        super.layoutIfNeeded()

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
        titleHeight.constant = ceil(expectedTitleHeight)
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
}

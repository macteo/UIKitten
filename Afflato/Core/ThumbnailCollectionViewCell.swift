//
//  ThumbnailCollectionViewCell.swift
//  Afflato
//
//  Created by Matteo Gavagnin on 14/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import Foundation

public class ThumbnailCollectionViewCell: SubtitleCollectionViewCell {
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
            layoutIfNeeded()
        }
    }
    
    var thumbnailViewSize : CGFloat = 0
    var thumbnailViewWidth : NSLayoutConstraint?
    var thumbnailViewLeadingMargin : NSLayoutConstraint?
    var thumbnailViewVerticalAlign : NSLayoutConstraint?
    
    public var thumbnailAlign : Align = .middle {
        didSet {
            layoutIfNeeded()
        }
    }
    
    override func commonInit() {
        super.commonInit()
        
        if thumbnailView.superview != nil {
            thumbnailView.removeFromSuperview()
        }
        
        thumbnailView.frame = CGRect(x: padding.left, y: padding.top, width: thumbnailViewSize, height: thumbnailViewSize)
        thumbnailView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailView.accessibilityIdentifier = "CellThumbnailView"
        mainView.addSubview(thumbnailView)
        
        thumbnailViewWidth = NSLayoutConstraint(item: thumbnailView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: thumbnailViewSize)
        mainView.addConstraint(thumbnailViewWidth!)
        
        thumbnailViewLeadingMargin = NSLayoutConstraint(item: mainView, attribute: .leading, relatedBy: .equal, toItem: thumbnailView, attribute: .leading, multiplier: 1, constant: -padding.left)
        mainView.addConstraint(thumbnailViewLeadingMargin!)
        mainView.addConstraint(NSLayoutConstraint(item: thumbnailView, attribute: .height, relatedBy: .equal, toItem: thumbnailView, attribute: .width, multiplier: 1, constant: 1))
        
        if let titleLeadingMargin = titleLeadingMargin {
            mainView.removeConstraint(titleLeadingMargin)
        }
        
        titleLeadingMargin = NSLayoutConstraint(item: thumbnailView, attribute: .trailing, relatedBy: .equal, toItem: titleLabel, attribute: .leading, multiplier: 1, constant: -padding.left)
        mainView.addConstraint(titleLeadingMargin!)
        
        layoutIfNeeded()
    }
    
    public override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
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
        
        thumbnailViewWidth?.constant = thumbnailViewSize
        
        if thumbnailViewSize != 0 {
            titleLeadingMargin?.constant = -padding.left
        } else {
            titleLeadingMargin?.constant = 0
        }
    }
}

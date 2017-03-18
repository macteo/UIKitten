//
//  SubtitleCollectionViewCell.swift
//  Afflato
//
//  Created by Matteo Gavagnin on 14/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import Foundation

public class ImageCollectionViewCell: SubtitleCollectionViewCell {
    let imageView = UIImageView()

    var image : UIImage? {
        didSet {
            imageView.image = image
            // TODO: show or hide image view base if image is present or not
            if let _ = image  {
                imageViewSize = 32
            } else {
                imageViewSize = 0
            }
            layoutIfNeeded()
        }
    }
    
    var imageViewSize : CGFloat = 32
    var imageViewWidth : NSLayoutConstraint?
    var imageViewLeadingMargin : NSLayoutConstraint?
    
    override func commonInit() {
        super.commonInit()
        
        if imageView.superview != nil {
            imageView.removeFromSuperview()
        }
        
        imageView.frame = CGRect(x: padding.left, y: padding.top, width: imageViewSize, height: imageViewSize)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        imageViewWidth = NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: imageViewSize)
        addConstraint(imageViewWidth!)
        
        // TODO: switch between those two lines to align the image to the top or center it vertically to the cell
        // addConstraint(NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: padding.top))
        addConstraint(NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: imageView, attribute: .centerY, multiplier: 1, constant: 1))
        imageViewLeadingMargin = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: imageView, attribute: .leading, multiplier: 1, constant: -padding.left)
        addConstraint(imageViewLeadingMargin!)
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: imageView, attribute: .width, multiplier: 1, constant: 1))
        
        if let titleLeadingMargin = titleLeadingMargin {
            removeConstraint(titleLeadingMargin)
        }
        
        titleLeadingMargin = NSLayoutConstraint(item: imageView, attribute: .trailing, relatedBy: .equal, toItem: titleLabel, attribute: .leading, multiplier: 1, constant: -padding.left)
        addConstraint(titleLeadingMargin!)
    }
    
    public override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        imageViewWidth?.constant = imageViewSize
        
        if imageViewSize != 0 {
            titleLeadingMargin?.constant = -padding.left
        } else {
            titleLeadingMargin?.constant = 0
        }
    }
}

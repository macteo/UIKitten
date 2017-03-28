//
//  ImageView.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 26/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit

open class ImageView: UIImageView, Alignable {
    public var width: Width?
    public var height: Height?

    // Alignable protocol
    public var padding : Int = 0
    public var align : Align = [.top, .left]

    var heightConstraint : NSLayoutConstraint?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public override init(image: UIImage?) {
        super.init(image: image)
        bounds.size = CGSize(width: 10, height: 10)
        commonInit()
    }
    
    public override init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        bounds.size = CGSize(width: 10, height: 10)
        commonInit()
    }
    
    func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .red
        contentMode = .scaleAspectFit
        if let heightConstraint = heightConstraint {
            removeConstraint(heightConstraint)
        }
        heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 10)
        addConstraint(heightConstraint!)
        
        adaptToImage()
    }
    
    open override var image: UIImage? {
        didSet {
            adaptToImage()
        }
    }
    
    func adaptToImage() {
        // TODO: only if some parameter to match height is set
        if let image = image {
            let proportionalHeight = bounds.size.width / image.size.width * image.size.height
            heightConstraint?.constant = proportionalHeight
        } else {
            heightConstraint?.constant = 0
        }
    }
    
    open override func layoutSubviews() {
        adaptToImage()
        super.layoutSubviews()
    }
}

//
//  GroupedButtons.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 15/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit

public class GroupedButtons : UIView {
    fileprivate var heightConstraint : NSLayoutConstraint?
    
    public var type : ButtonType = .normal {
        didSet {
            layoutIfNeeded()
        }
    }
    
    @IBInspectable public var typeString : String = "normal" {
        didSet {
            guard let typed = ButtonType(rawValue: typeString) else { return }
            type = typed
        }
    }

    fileprivate var buttons : [Button]?
    fileprivate let stackView = UIStackView()
    
    public var distribution : UIStackViewDistribution = .fillEqually {
        didSet {
            stackView.distribution = distribution
            layoutIfNeeded()
        }
    }
    
    public var axis : UILayoutConstraintAxis = .vertical {
        didSet {
            stackView.axis = axis
            
            layoutIfNeeded()
        }
    }
    
    public var spacing : CGFloat = 0 {
        didSet {
            stackView.spacing = spacing
            layoutIfNeeded()
            if spacing == 0 {
                for button in stackView.arrangedSubviews {
                    if let button = button  as? Button {
                        button.style = .grouped
                    }
                }
                
            } else {
                for button in stackView.arrangedSubviews {
                    if let button = button  as? Button {
                        // TODO: don't override the button original style
                        button.style = .normal
                    }
                }
            }
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public init(frame: CGRect, buttons: [Button], axis: UILayoutConstraintAxis = .horizontal) {
        super.init(frame: frame)
        self.buttons = buttons
        self.axis = axis
        commonInit()
    }
    
    func commonInit() {
        if axis == .horizontal {
            bounds.size.height = Size.normal.height
        } else {
            bounds.size.height = Size.normal.height * CGFloat(stackView.arrangedSubviews.count) + CGFloat(stackView.arrangedSubviews.count - 1) * spacing
        }
        
        layer.cornerRadius = Style.normal.cornerRadius(height: bounds.size.height)
        layer.masksToBounds = true
        
        if stackView.superview != nil {
            stackView.removeFromSuperview()
        }
        stackView.frame = bounds
        stackView.axis = axis
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        addConstraint(NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: stackView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: stackView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: stackView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0))
        
        guard let buttons = buttons else { return }
        
        for arrangedView in stackView.arrangedSubviews {
            stackView.removeArrangedSubview(arrangedView)
        }
        
        for button in buttons {
            stackView.addArrangedSubview(button.style(.grouped))
        }
        
        if axis == .horizontal {
            bounds.size.height = Size.normal.height
        } else {
            bounds.size.height = Size.normal.height * CGFloat(stackView.arrangedSubviews.count) + CGFloat(stackView.arrangedSubviews.count - 1) * spacing
        }
        stackView.frame.size.height = bounds.size.height
        
        layoutIfNeeded()
    }
    
    public func insert(button: Button, at: Int, animated: Bool = true) {
        if animated && axis == .horizontal {
            button.isHidden = true
        }
        if spacing == 0 {
            button.style = .grouped
        }
        
        stackView.insertArrangedSubview(button, at: at)

        if animated && axis == .horizontal {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                UIView.animate(withDuration: 0.25, animations: {
                    button.isHidden = false
                })
            }
        } else {
            layoutIfNeeded()
        }
    }
    
    public func remove(button: Button, animated: Bool = true) {
        if animated && axis == .horizontal {
            UIView.animate(withDuration: 0.25, animations: {
                button.isHidden = true
            }) { (complete) in
                self.stackView.removeArrangedSubview(button)
                button.removeFromSuperview()
            }
        } else {
            self.stackView.removeArrangedSubview(button)
            button.removeFromSuperview()
            layoutIfNeeded()
        }
    }
    
    public override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        layer.borderWidth = type.borderWidth
        
        if spacing == 0 {
            layer.borderColor = type.borderColor.cgColor
            cornerRadius = Style.normal.cornerRadius(height: bounds.size.height)
        } else {
            layer.borderColor = UIColor.clear.cgColor
            cornerRadius = 0
        }
        
        if heightConstraint == nil {
            heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1)
            addConstraint(heightConstraint!)
        }
        
        guard let heightConstraint = heightConstraint else { return }

        if axis == .vertical {
            heightConstraint.constant = Size.normal.height * CGFloat(stackView.arrangedSubviews.count) + CGFloat(stackView.arrangedSubviews.count - 1) * spacing
        } else {
            heightConstraint.constant = Size.normal.height
        }
        
        frame.size.height = heightConstraint.constant
        stackView.frame.size.height = bounds.size.height
    }
}

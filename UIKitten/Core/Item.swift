//
//  Item.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 20/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

public class Item : ListItem {
    public init(title: String? = nil, subtitle: String? = nil, image: UIImage? = nil, view: UIView? = nil, action: ((_ cell: BaseCollectionViewCell?, _ selected: Bool) -> Void)? = nil) {
        _title = title
        _subtitle = subtitle
        _image = image
        _action = action
        _view = view
    }
        
    public var _title: String? = nil
    public var _subtitle: String? = nil
    public var _image: UIImage? = nil
    public var _imageUrl: URL? = nil
    public var _view: UIView? = nil
    public var _action : ((_ cell: BaseCollectionViewCell?, _ selected: Bool) -> Void)? = nil
    
    public func itemTitle() -> String? {
        return _title
    }
    
    public func itemSubtitle() -> String? {
        return _subtitle
    }
    
    
    public func itemImage() -> UIImage? {
        return _image
    }
    
    public func itemImageUrl() -> URL? {
        return _imageUrl
    }
    
    public func itemAction() -> ((_ cell : BaseCollectionViewCell?, _ selected: Bool) -> Void)? {
        return _action
    }
    
    public func itemView() -> UIView? {
        return _view
    }
}

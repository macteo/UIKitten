//
//  Item.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 20/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

public class Item : ListItem {
    public init(title: String? = nil, subtitle: String? = nil, image: UIImage? = nil, view: UIView? = nil, action: ((_ cell: BaseCollectionViewCell?, _ selected: Bool) -> Void)? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.action = action
        self.view = view
    }
        
    public var title: String? = nil
    public var subtitle: String? = nil
    public var image: UIImage? = nil
    public var imageUrl: URL? = nil
    public var view: UIView? = nil
    public var action : ((_ cell: BaseCollectionViewCell?, _ selected: Bool) -> Void)? = nil
}

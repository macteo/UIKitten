//
//  Item.swift
//  Afflato
//
//  Created by Matteo Gavagnin on 20/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

public class Item : ListItem {
    public init(title: String, subtitle: String, image: UIImage?, action: @escaping ((_ cell: BaseCollectionViewCell?, _ selected: Bool) -> Void)) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.action = action
    }
    
    public init(title: String, image: UIImage?, action: @escaping ((_ cell: BaseCollectionViewCell?, _ selected: Bool) -> Void)) {
        self.title = title
        self.image = image
        self.action = action
    }
    
    public init(title: String, image: UIImage?) {
        self.title = title
        self.image = image
    }
    
    public init(title: String) {
        self.title = title
    }
    
    public init(title: String, subtitle: String, image: UIImage?) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
    }
    
    public init(title: String, action: @escaping ((_ cell: BaseCollectionViewCell?, _ selected: Bool) -> Void)) {
        self.title = title
        self.action = action
    }
    
    public var title: String?
    public var subtitle: String?
    public var image: UIImage?
    public var imageUrl: URL?
    public var action : ((_ cell: BaseCollectionViewCell?, _ selected: Bool) -> Void)?
}

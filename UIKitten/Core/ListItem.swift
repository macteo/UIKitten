//
//  ListItem.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 20/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

public protocol ListItem {
    func itemTitle() -> String?
    func itemSubtitle() -> String?
    func itemImage() -> UIImage?
    func itemImageUrl() -> URL?
    func itemAction() -> ((_ cell : BaseCollectionViewCell?, _ selected: Bool) -> Void)? // TODO: use a generic cell
    func itemView() -> UIView?
}

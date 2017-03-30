//
//  ListItem.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 20/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit

public protocol ListItem {
    func itemTitle() -> String?
    func itemSubtitle() -> String?
    func itemImage() -> UIImage?
    func itemImageUrl() -> URL?
    func itemAction() -> ((_ cell : Cell?, _ selected: Bool) -> Void)?
    func itemView() -> UIView?
    func cellType() -> CellType
}

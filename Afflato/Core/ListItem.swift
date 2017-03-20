//
//  ListItem.swift
//  Afflato
//
//  Created by Matteo Gavagnin on 20/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

public protocol ListItem {
    var title: String? { get }
    var subtitle: String? { get }
    var image: UIImage? { get }
    var imageUrl : URL? { get }
    var action : ((_ cell : BaseCollectionViewCell?, _ selected: Bool) -> Void)? { get }
}

//
//  ListController.swift
//  Afflato Catalog
//
//  Created by Matteo Gavagnin on 20/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit
import Afflato

class ListController: TableController {

    override func viewDidLoad() {
        super.viewDidLoad()

        items = [
            [Item(title: "Image title with subtitle", subtitle: "This is so amazing I'm not even able to understand how it works. Wonderful!", image: #imageLiteral(resourceName: "tableImage"), action: {
                cell, selected in
                cell?.footerIsVisible = selected
            })],
            [Item(title: "Hi")]
        ]
    }
}

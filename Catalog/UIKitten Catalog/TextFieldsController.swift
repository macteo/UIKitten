//
//  TextFieldsTableController.swift
//  UIKitten Catalog
//
//  Created by Matteo Gavagnin on 20/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKitten

class TextFieldsController: TableController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        navigationItem.leftItemsSupplementBackButton = true
        
        items = [
            [UsernameField(frame: CGRect(x: 0, y:0, width: 260, height: 22)).align([.center, .middle]),
             EmailField(frame: CGRect(x: 0, y:0, width: 260, height: 22)).align([.center, .middle]),
             PasswordField(frame: CGRect(x: 0, y:0, width: 260, height: 22)).align([.center, .middle])
             ]
        ]
    }
}

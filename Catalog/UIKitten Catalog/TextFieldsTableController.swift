//
//  TextFieldsTableController.swift
//  UIKitten Catalog
//
//  Created by Matteo Gavagnin on 20/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKitten

class TextFieldsTableController: TableController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = [
            [Item(title: "Image title with subtitle", subtitle: "This is so amazing I'm not even able to understand how it works. Wonderful!", image: #imageLiteral(resourceName: "tableImage"), action: {
                cell, selected in
                cell?.footerIsVisible = selected
            })],
            [Item(view: Button(icon: .arrowRight, title: "Right").imagePosition(.right).padding(10).align([.middle, .right]).type(.primary)),
             Item(view: Button(icon: .arrowLeft, title: "Left").padding(10).align([.middle, .left]).type(.warning)),
             Item(view: Button(icon: .arrowUp, title: "Up").align([.middle, .center]).style(.rounded).type(.danger)),
             Item(view: Button(icon: .arrowDown).align([.middle, .center]).style(.dropShadow).type(.info)),
             Item(view: Button(icon: .birthdayCake, title: "This is a\nbirthday cake.").align([.middle, .center]).type(.success))]
        ]
    }
}

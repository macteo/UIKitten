//
//  OverviewViewController.swift
//  UIKitten Catalog
//
//  Created by Matteo Gavagnin on 24/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKitten

class OverviewViewController: TableController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        items = [
            [Item(title: "Image title with subtitle", subtitle: "This is so amazing I'm not even able to understand how it works. Wonderful!", image: #imageLiteral(resourceName: "tableImage"), action: {
                cell, selected in
                cell?.footerIsVisible = selected
            })],
            [Button(icon: .arrowRight, title: "Right").imagePosition(.right).align([.middle, .right]).type(.primary),
             Button(icon: .arrowLeft, title: "Left").align([.middle, .left]).type(.warning),
             Button(icon: .arrowUp, title: "Up").align([.middle, .center]).style(.rounded).type(.danger),
             Button(icon: .arrowDown).align([.middle, .center]).style(.dropShadow).type(.info),
             Button(icon: .birthdayCake, title: "This is a\nbirthday cake.").align([.middle, .center]).type(.success)],
            [ImageView(image: #imageLiteral(resourceName: "tableImage"))],
            [BarChart(frame: CGRect(x: 0, y: 0, width: 260, height: 120))]
        ]
    }
}

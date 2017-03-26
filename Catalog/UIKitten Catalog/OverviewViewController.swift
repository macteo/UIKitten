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
        
        // TODO: architect a way to default to 100% of container if not specified otherwise
        // TODO: architect a way to specify width and height in points

        let imageView = ImageView(image: #imageLiteral(resourceName: "tableImage"))
        
        // let imageView = ImageView(frame: CGRect(x: 0, y: 0, width: 160, height: 300))
        imageView.image = #imageLiteral(resourceName: "tableImage")
        
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
            [imageView]
        ]
    }
}

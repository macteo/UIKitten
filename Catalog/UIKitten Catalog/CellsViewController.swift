//
//  CellsViewController.swift
//  UIKitten Catalog
//
//  Created by Matteo Gavagnin on 21/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKitten

class CellsViewController: TableController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gitlab = Button(icon: .gitlab, title: "GitLab\nWhat a pleasure\nto meet you", position: .left).align([.middle, .center]).padding(10)
        let github = Button(icon: .github, title: "GitHub", position: .right).align([.right, .top])
        let git = Button(icon: .git, title: "Git").align([.left, .bottom])

        let square = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        square.backgroundColor = .success
        square.layer.cornerRadius = 8
        square.layer.masksToBounds = true
        square.autoresizingMask = [.flexibleRightMargin]

        let counter = Item(title: "Sales", value: 935, image: UIImage.fontAwesomeIcon(name: .tags, textColor: .white, size: CGSize(width: 128, height: 128)).withRenderingMode(.alwaysTemplate))
        
        items = [
            [Item(view: square), Item(view: gitlab), Item(view: github), Item(view: git), counter]
        ]
    }
}

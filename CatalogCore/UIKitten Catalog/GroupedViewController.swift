//
//  GroupedViewController.swift
//  UIKitten Catalog
//
//  Created by Matteo Gavagnin on 14/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit
import UIKitten

class GroupedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        navigationItem.leftItemsSupplementBackButton = true
        
        view.backgroundColor = .white
        
        let firstButton = Button(title: "arrowLeft").type(.danger)
        let secondButton = Button(title: "Horizontal").type(.primary)
        let thirdButton = Button(title: "arrowRight").type(.info)
        
        let groupedButtons = GroupedButtons(frame: CGRect(x: 10, y: 100, width: view.bounds.size.width - 20, height: 20), buttons: [firstButton, secondButton], axis: .horizontal)
        groupedButtons.autoresizingMask = [.flexibleWidth]
        groupedButtons.distribution = .fillEqually
        groupedButtons.spacing = 0
        view.addSubview(groupedButtons)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            groupedButtons.insert(button: thirdButton, at: 2)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                groupedButtons.remove(button: thirdButton)
            }
        }
        
        let upButton = Button(title: "arrowUp").type(.primary)
        let middleButton = Button(title: "Vertical").type(.normal)
        let downButton = Button(title: "arrowDown").type(.warning)
        
        let groupedVerticalButtons = GroupedButtons(frame: CGRect(x: 10, y: 200, width: view.bounds.size.width - 20, height: 20), buttons: [upButton, middleButton, downButton], axis: .vertical)
        groupedVerticalButtons.autoresizingMask = [.flexibleWidth]
        groupedVerticalButtons.distribution = .fillEqually
        groupedVerticalButtons.spacing = 0
        view.addSubview(groupedVerticalButtons)
    }
}

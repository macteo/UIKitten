//
//  GroupedViewController.swift
//  Afflato Catalog
//
//  Created by Matteo Gavagnin on 14/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit
import Afflato

class GroupedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let firstButton = Button(icon: .arrowLeft).type(.danger)
        let secondButton = Button(title: "Hello!").type(.primary)
        let thirdButton = Button(icon: .arrowRight).type(.info)
        
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
    }
}

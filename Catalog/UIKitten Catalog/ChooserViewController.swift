//
//  ChooserViewController.swift
//  UIKitten Catalog
//
//  Created by Matteo Gavagnin on 29/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKitten

class ChooserViewController: TableController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let overview = Item(title: "Overview") { (cell, selected) in
            guard selected else { return }
            let controller = OverviewViewController()
            self.show(controller, sender: nil)
        }
        
        let charts = Item(title: "Charts") { (cell, selected) in
            guard selected else { return }
            let controller = ChartsViewController()
            self.show(controller, sender: nil)
        }
        
        let buttons = Item(title: "Buttons") { (cell, selected) in
            guard selected else { return }
            let controller = ButtonsController()
            self.show(controller, sender: nil)
        }
        
        let textFields = Item(title: "Text Fields") { (cell, selected) in
            guard selected else { return }
            let controller = TextFieldsController()
            self.show(controller, sender: nil)
        }
        
        let layout = Item(title: "Layout") { (cell, selected) in
            guard selected else { return }
            if let controller = self.storyboard?.instantiateViewController(withIdentifier: "layoutViewController") {
                self.show(controller, sender: nil)
            }
        }
        
        let grouped = Item(title: "Grouped Buttons") { (cell, selected) in
            guard selected else { return }
            let controller = GroupedViewController()
            self.show(controller, sender: nil)
        }
        
        let list = Item(title: "List") { (cell, selected) in
            guard selected else { return }
            let controller = ListController()
            self.show(controller, sender: nil)
        }
        
        let cells = Item(title: "Cells") { (cell, selected) in
            guard selected else { return }
            let controller = CellsViewController()
            self.show(controller, sender: nil)
        }
        
        items = [
            [overview, charts, buttons, textFields, layout, grouped, list, cells]
        ]
    }

}

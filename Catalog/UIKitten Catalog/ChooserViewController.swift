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
        
        navigationItem.title = "UIKitten"

        let overview = forgeCell(title: "Overview", image: #imageLiteral(resourceName: "kitten"))
        let charts = forgeCell(title: "Charts")
        let buttons = forgeCell(title: "Buttons", image: #imageLiteral(resourceName: "buttons"))
        let textFields = forgeCell(title: "Text Fields", image: #imageLiteral(resourceName: "text-fields"))
        let layout = forgeCell(title: "Layout")
        let grouped = forgeCell(title: "Grouped Buttons")
        let list = forgeCell(title: "List")
        let cells = forgeCell(title: "Cells")
        let cards = forgeCell(title: "Cards")
        
        items = [
            [overview, charts, buttons, textFields, layout, grouped, list, cells, cards]
        ]
    }
    
    func forgeCell(title: String, image: UIImage? = nil) -> Item {
        let cell = Item(title: title, image: image) { (cell, selected) in
            guard selected else { return }
            var controller : UIViewController?
            switch title {
            case "Overview":
                controller = OverviewViewController()
                break
            case "Charts":
                controller = ChartsViewController()
                break
            case "Buttons":
                controller = ButtonsController()
                break
            case "Text Fields":
                controller = TextFieldsController()
                break
            case "Layout":
                controller = self.storyboard?.instantiateViewController(withIdentifier: "layoutViewController")
                break
            case "Grouped Buttons":
                controller = GroupedViewController()
                break
            case "List":
                controller = ListController()
                break
            case "Cells":
                controller = CellsViewController()
                break
            case "Cards":
                controller = CardsViewController()
                break
            default:
                break
            }
            guard let c = controller else { return }
            c.navigationItem.title = title
            self.show(c, sender: nil)
        }
        return cell
    }

}

//
//  ButtonsController.swift
//  UIKitten Catalog
//
//  Created by Matteo Gavagnin on 21/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKitten

class ButtonsController: TableController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let primary = Button(icon: .diamond, title: "Primary").type(.primary)
        let info = Button(icon: .info, title: "Info").type(.info)
        let success = Button(icon: .check, title: "Success").type(.success)
        let warning = Button(icon: .exclamationTriangle, title: "Warning").type(.warning)
        let danger = Button(icon: .close, title: "Danger").type(.danger)
        let normalType = Button(icon: .adjust, title: "Normal")
        let clean = Button(icon: .envelopeO, title: "Clean").type(.clean)
        
        let types = [primary, info, success, warning, danger, normalType, clean]
        
        let extraSmall = Button(title: "Extra Small").align(.right).size(.extraSmall)
        let small = Button(title: "Small").align(.right).size(.small)
        let normalSize = Button(title: "Normal").align(.right)
        let large = Button(title: "Large").align(.right).size(.large)
        
        let sizes = [extraSmall, small, normalSize, large]
        
        let left = Button(icon: .handOLeft, title: "Left").align(.left).size(.extraSmall)
        let center = Button(icon: .arrowsH, title: "Center").align(.center).size(.extraSmall)
        let right = Button(icon: .handORight, title: "Right", position: .right).align(.right).size(.extraSmall)
        // FIXME: this doesn't work anymore inside a cell
        let middle = Button(icon: .arrowsV, title: "Middle").align([.center, .middle]).size(.extraSmall)
        let top = Button(icon: .arrowUp, title: "Top").align([.center, .top]).size(.extraSmall)
        let bottom = Button(icon: .arrowDown, title: "Bottom").align([.center, .bottom]).size(.extraSmall)
        
        let alignment = [left, center, right, top, middle, bottom]
        
        let multiline = Button(title: "Multiline buttons\nare also supported").type(.success).align([.top, .center])
        
        let lines = [multiline]
        
        let rounded = Button(title: "Rounded").style(.rounded).type(.primary)
        let dropShadow = Button(title: "Drop Shadow").style(.dropShadow).type(.primary)
        let glass = Button(title: "Frosted Glass").style(.glass).type(.primary)
        let normal = Button(title: "Normal").type(.primary)
        
        let styles = [rounded, dropShadow, glass, normal]
        
        let action = Button(title: "Action").style(.rounded).type(.info).tap {
            let alert = UIAlertController(title: "Button Action", message: "Isn't UIKitten awesome?", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "YES!", style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: {
                    
                })
            })
            alert.addAction(yesAction)
            self.present(alert, animated: true, completion: nil)
        }
        
        let actions = [action]
        
        let firstButton = Button(icon: .arrowLeft).type(.danger)
        let secondButton = Button(title: "Grouped").type(.primary)
        let thirdButton = Button(icon: .arrowRight).type(.info)

        let groupedButtons = GroupedButtons(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 36), buttons: [firstButton, secondButton, thirdButton], axis: .horizontal)
        groupedButtons.width = .container(ratio: 1)
        groupedButtons.distribution = .fillProportionally
        groupedButtons.spacing = 0

        let grouped = [groupedButtons]

        let imageOnly = Button(icon: .camera).type(.clean).size(.small)
        
        items = [types, sizes, alignment, lines, styles, actions, grouped, [imageOnly]]
    }
}

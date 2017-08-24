//
//  LayoutViewController.swift
//  UIKitten Catalog
//
//  Created by Matteo Gavagnin on 09/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit
import UIKitten
import FontAwesome_swift

class LayoutViewController: UIViewController {
    @IBOutlet var warningButton: Button!

    @IBAction func buttonPressed(_ sender: UIButton) {
        
    }
    
    @IBOutlet var gitHubButton: Button!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        navigationItem.leftItemsSupplementBackButton = true

        warningButton.setTitle("This is a long\nmultiline\nbutton", for: .normal)
        
        
        let _ = Button(icon: .github).align([.top, .left]).margin(top: 70, left: 20).tap {
            print("Tapped GitHub")
            guard let warningButton = self.warningButton else { return }
            if warningButton.type == .warning {
                warningButton.type = .success
            } else {
                warningButton.type = .warning
            }
        }.add(to: view)

        let nextButton = Button(icon: .arrowRight, title: "Next".uppercased(), position: .left).margin(right: 20).type(.primary).align([.middle, .right]).add(to: view)
        
        let vertical = Vertical.below(view: nextButton)
        let _ = Label(text: "Hello World, a great long and beatiful world").vertical(vertical).align([.top, .left]).margin(top: 4, left: 0).add(to: view)
        
        // TODO: fixme the badge
        let anguria = Button(title: "Watermelon").align([.center, .bottom])
                                        .style(.dropShadow)
                                        .margin(bottom: 10)
                                        .type(.info)
                                        .size(.large)
                                        .tap {
                                            
                                            let tableController = TableController()
                                            
                                            tableController.items = [
                                                [Item(title: "Hello"), Item(title: "Dinner"), Item(title: "This title is way longer that usual, but the cell adapts itself so we can be sure that everything is in place")],
                                                [Item(title: "Close", action: {
                                                    cell, selected in
                                                    if selected {
                                                        let _ = tableController.navigationController?.popViewController(animated: true)
                                                    }
                                                })],
                                                [Item(title: "Image title", image: #imageLiteral(resourceName: "tableImage"))],
                                                [Item(title: "Image title with subtitle", subtitle: "This is so amazing I'm not even able to understand how it works. Wonderful!", image: #imageLiteral(resourceName: "tableImage"))]
                                            ]
                                            
                                            self.show(tableController, sender: nil)
        }.add(to: view)
        
        // let badge = Badge(frame: CGRect(x: 0, y: 100, width: 100, height: 10))
        // let _ = badge.snap(to: anguria)
        
        // DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//             badge.value = "12"
//         }
    }
}


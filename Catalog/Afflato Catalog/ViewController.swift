//
//  ViewController.swift
//  Afflato Catalog
//
//  Created by Matteo Gavagnin on 09/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit
import Afflato
import FontAwesome_swift

class ViewController: UIViewController {
    @IBOutlet var warningButton: Button!

    @IBAction func buttonPressed(_ sender: UIButton) {
        
    }
    @IBOutlet var gitHubButton: Button!

    override func viewDidLoad() {
        super.viewDidLoad()

        warningButton.setTitle("Fagiolo malefico\nsenza pudore\ne con il bisogno di legumi", for: .normal)
        
        let _ = Button(icon: .github).padding(20).tap {
            print("Tapped GitHub")
            guard let warningButton = self.warningButton else { return }
            if warningButton.type == .warning {
                warningButton.type = .success
            } else {
                warningButton.type = .warning
            }
        }.add(to: view)

        let _ = Button(icon: .arrowRight, title: "Next".uppercased(), position: .left).type(.primary).align([.middle, .right]).add(to: view)
        
        let _ = Button(title: "Anguria").align([.center, .bottom])
                                        .padding(10)
                                        .style(.dropShadow)
                                        .type(.danger)
                                        .size(.large)
                                        .tap {
            
                                            let tableController = TableController()
                                            
                                            tableController.items = [
                                                [Title("Ciaone"), Title("Merenda"), Title("This title is way longer that usual, but the cell adapts itself so we can be sure that everything is in place")],
                                                [TitleAction("Close", action: {
                                                    selected in
                                                    print("Cell selected: \(selected)")
                                                    if selected {
                                                        let _ = tableController.navigationController?.popViewController(animated: true)
                                                    }
                                                })],
                                                [ImageTitleAction("Image title", image: #imageLiteral(resourceName: "tableImage"))],
                                                [ImageTitleAction("Image title with subtitle", subtitle: "This is so amazing I'm not even able to understand how it works. Wonderful!", image: #imageLiteral(resourceName: "tableImage"))]
                                            ]
                                            
                                            self.show(tableController, sender: nil)
        }.add(to: view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


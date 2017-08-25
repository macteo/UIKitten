//
//  LabelViewController.swift
//  UIKitten Catalog
//
//  Created by Matteo Gavagnin on 25/08/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit
import UIKitten
import FontAwesome_swift

class LabelViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let nextButton = Button(icon: .arrowRight, title: "Next".uppercased(), position: .left).margin(right: 20).type(.primary).align([.middle, .right]).add(to: view)
        nextButton.align = Align.right
        
        let _ = Label(text: "Hello World, a great long and beatiful world thta it's not what I intended, however it seems pretty solid.\nHello World, a great long and beatiful world thta it's not what I intended, however it seems pretty solid.\nHello World, a great long and beatiful world thta it's not what I intended, however it seems pretty solid.\nHello World, a great long and beatiful world thta it's not what I intended, however it seems pretty solid.\nHello World, a great long and beatiful world thta it's not what I intended, however it seems pretty solid.\nHello World, a great long and beatiful world thta it's not what I intended, however it seems pretty solid.\nHello World, a great long and beatiful world thta it's not what I intended, however it seems pretty solid.\n").below(nextButton).align([.top, .left]).margin(top: 4, left: 0).add(to: view)
        
    }
}

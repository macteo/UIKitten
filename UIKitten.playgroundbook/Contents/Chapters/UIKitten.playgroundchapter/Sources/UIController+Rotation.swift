//
//  UIController+Rotation.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 15/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit

extension UINavigationController {
    override open var supportedInterfaceOrientations : UIInterfaceOrientationMask     {
        return .all
    }
}

extension UISplitViewController {
    override open var supportedInterfaceOrientations : UIInterfaceOrientationMask     {
        return .all
    }
}

extension UITabBarController {
    override open var supportedInterfaceOrientations : UIInterfaceOrientationMask     {
        return .all
    }
}

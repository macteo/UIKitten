//
//  UsernameField.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 15/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit
#if COCOAPODS
    import FontAwesome_swift
#endif

public class UsernameField: TextField {
    override func commonInit() {
        super.commonInit()
        
        keyboardType = .default
        isSecureTextEntry = false
        autocorrectionType = .no
        autocapitalizationType = .none
        spellCheckingType = .no
        
        leftImage = UIImage.fontAwesomeIcon(name: .user, style: .regular, textColor: tintColor, size: imageSize).withRenderingMode(.alwaysTemplate)
        placeholder = NSLocalizedString("Username", comment: "Username placeholder")
    }
}

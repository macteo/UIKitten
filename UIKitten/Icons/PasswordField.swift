//
//  PasswordField.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 15/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit
#if COCOAPODS
    import FontAwesome_swift
#endif

public class PasswordField: TextField {
    override func commonInit() {
        super.commonInit()
        
        keyboardType = .default
        isSecureTextEntry = true
        autocorrectionType = .no
        autocapitalizationType = .none
        spellCheckingType = .no
        clearsOnBeginEditing = true
        
        leftImage = UIImage.fontAwesomeIcon(name: .key, style: .regular, textColor: tintColor, size: imageSize).withRenderingMode(.alwaysTemplate)
        placeholder = NSLocalizedString("Password", comment: "Password placeholder")
    }
}

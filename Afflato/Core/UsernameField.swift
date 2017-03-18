//
//  UsernameField.swift
//  Afflato
//
//  Created by Matteo Gavagnin on 15/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit
import FontAwesome_swift

public class UsernameField: TextField {
    override func commonInit() {
        super.commonInit()
        
        keyboardType = .default
        isSecureTextEntry = false
        autocorrectionType = .no
        autocapitalizationType = .none
        spellCheckingType = .no
        
        leftImage = UIImage.fontAwesomeIcon(name: .user, textColor: tintColor, size: imageSize).withRenderingMode(.alwaysTemplate)
        placeholder = NSLocalizedString("Username", comment: "Username placeholder")
    }
}

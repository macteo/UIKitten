//
//  EmailTextField.swift
//  Afflato
//
//  Created by Matteo Gavagnin on 10/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit
import FontAwesome_swift

let afflatoBundle = Bundle(for:Afflato.Button.self)

public class EmailField: TextField {
    override func commonInit() {
        super.commonInit()
        
        keyboardType = .emailAddress
        autocorrectionType = .no
        autocapitalizationType = .none
        spellCheckingType = .no
        
        leftImage = UIImage.fontAwesomeIcon(name: .envelopeO, textColor: tintColor, size: imageSize).withRenderingMode(.alwaysTemplate)
        
        placeholder = NSLocalizedString("Email", comment: "Email placeholder")
        let emailRegex = Validation(regex: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}", message: NSLocalizedString("Please insert a valid email address", comment: "Email validation format error"))
        validations = [emailRegex]
    }
}

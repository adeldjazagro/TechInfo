//
//  CurrencyTextField.swift
//  TechInfo
//
//  Created by Adel on 07/05/2019.
//  Copyright © 2019 Adel. All rights reserved.
//

import UIKit
@IBDesignable

class CurrencyTextField: UITextField {
    
    override func prepareForInterfaceBuilder() {
        custumizeView()
    }

    override func awakeFromNib() {
        super.awakeFromNib()


    }
    func custumizeView() {
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        layer.cornerRadius = 5.0
        textAlignment = .center

        if let p = placeholder {
            let place = NSAttributedString(string: p, attributes: [.foregroundColor : UIColor.white])
            attributedPlaceholder = place
            textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
  
}

//
//  floatingTextField.swift
//  TechInfo
//
//  Created by Adel on 30/05/2019.
//  Copyright © 2019 Adel. All rights reserved.
//

import Foundation

import UIKit

class FloatingLabeledTextField: UITextField {
    
    var floatingLabel: UILabel!
    var placeHolderText: String?
    
    var floatingLabelColor: UIColor = UIColor.blue {
        didSet {
            self.floatingLabel.textColor = floatingLabelColor
        }
    }
        var floatingLabelFont: UIFont = UIFont.systemFont(ofSize: 15) {
        
        didSet {
        self.floatingLabel.font = floatingLabelFont
        }
        }
        
        var floatingLabelHeight: CGFloat = 30
        
        override init(frame: CGRect) {
        super.init(frame: frame)
        }
        
        required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        let flotingLabelFrame = CGRect(x: 0, y: 0, width: frame.width, height: 0)
        
        floatingLabel = UILabel(frame: flotingLabelFrame)
        floatingLabel.textColor = floatingLabelColor
        floatingLabel.font = floatingLabelFont
        floatingLabel.text = self.placeholder
        
        self.addSubview(floatingLabel)
        placeHolderText = placeholder
        
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidBeginEditing), name: UITextField.textDidBeginEditingNotification, object: self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidEndEditing), name: UITextField.textDidEndEditingNotification, object: self)
        
        
        }
        
        @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if self.text == "" {
        UIView.animate(withDuration: 0.3) {
        self.floatingLabel.frame = CGRect(x: 0, y: -self.floatingLabelHeight, width: self.frame.width, height: self.floatingLabelHeight)
        }
        self.placeholder = ""
        }
        }
        
        @objc func textFieldDidEndEditing(_ textField: UITextField) {
        
        if self.text == "" {
        UIView.animate(withDuration: 0.1) {
        self.floatingLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 0)
        }
        self.placeholder = placeHolderText
        }
        }
        
        deinit {
        
        NotificationCenter.default.removeObserver(self)
        
        }
}


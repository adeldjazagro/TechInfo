//
//  RegistrationVC.swift
//  TechInfo
//
//  Created by Adel on 03/06/2019.
//  Copyright © 2019 Adel. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class RegistrationVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var firstNameTF: FloatingLabeledTextField!
    @IBOutlet weak var familyNameTF: FloatingLabeledTextField!
    @IBOutlet weak var emailTF: FloatingLabeledTextField!
    @IBOutlet weak var passwordTF: FloatingLabeledTextField!
    @IBOutlet weak var confirmPwdTF: FloatingLabeledTextField!
    
    
    
    @IBAction func nextBtn(_ sender: Any) {
       
        
        performSegue(withIdentifier: "secondRegistrationStep", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameTF.delegate = self
        familyNameTF.delegate = self
        emailTF.delegate = self
        passwordTF.delegate = self
        confirmPwdTF.delegate = self

        
        firstNameTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        familyNameTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        emailTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        passwordTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        confirmPwdTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)

        
    }
    

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var seconRegistrationVC = segue.destination as! SecondRegistrationVC
        seconRegistrationVC.Utilisateur["name"] = firstNameTF.text! as String
        seconRegistrationVC.Utilisateur["familyName"] = familyNameTF.text! as String
        seconRegistrationVC.Utilisateur["email"] = emailTF.text! as String
        seconRegistrationVC.Utilisateur["password"] = passwordTF.text! as String

        
    }
    
    @objc func textFieldChanged(_ target:UITextField) {
        let username = firstNameTF.text
        let email = emailTF.text
        let password = passwordTF.text
        let adress = familyNameTF.text
        let confirmPwd = confirmPwdTF.text
        let formFilled = username != nil && username != "" && email != nil && email != "" && password != nil && password != "" && adress != "" && adress != nil && confirmPwd != "" && confirmPwd != nil && confirmPwd == password
        //setContinueButton(enabled: formFilled)
    }
    

}

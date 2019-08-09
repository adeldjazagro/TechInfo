//
//  AddClientVC.swift
//  TechInfo
//
//  Created by Adel on 02/08/2019.
//  Copyright © 2019 Adel. All rights reserved.
//

import UIKit
import Firebase

class AddClientVC: UIViewController {

   
    @IBAction func SaveBtn(_ sender: Any) {
        saveClient()
    }
    
    @IBOutlet weak var NomClient: UITextField!
    @IBOutlet weak var Prenom: UITextField!
    @IBOutlet weak var Adress: UITextField!
    @IBOutlet weak var EmailClient: UITextField!
    @IBOutlet weak var PhoneClient: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func resetForm() {
        let alert = UIAlertController(title: "Vous avez bien ajouté votre client", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func saveClient() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let Ref = Database.database().reference().child("users/client/\(uid)")
        let databaseRef = Ref.childByAutoId()
    
    
    let newFact = [
        "nom": self.NomClient.text!,
        "prenom": self.Prenom.text!,
        "adress": self.Adress.text!,
        "email": self.EmailClient.text!,
        "phone": self.PhoneClient.text!
        
        ] as [String:Any]
    
    databaseRef.setValue(newFact)
        self.resetForm()
    }
}

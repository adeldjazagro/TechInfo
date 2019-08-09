//
//  FactureAddVc.swift
//  TechInfo
//
//  Created by Adel on 04/06/2019.
//  Copyright © 2019 Adel. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase

class FactureAddVc: UIViewController {
    
    var statut = ""
    @IBOutlet weak var envoye: UIButton!
    @IBOutlet weak var enregistre: UIButton!
    @IBOutlet weak var enattente: UIButton!
    
    
    
    

    @IBOutlet weak var ClientTF: UITextField!
    @IBOutlet weak var MontantHT: UITextField!
    @IBAction func EnvoyeBtn(_ sender: Any) {
        if enregistre.isSelected == true {
            envoye.isSelected = true
            enregistre.isSelected = false
            enattente.isSelected = false
        
        } else if enattente.isSelected == true{
            envoye.isSelected = true
            enregistre.isSelected = false
            enattente.isSelected = false
        } else {
            envoye.isSelected = true

        }
    }
    
    @IBAction func EnregitreBtn(_ sender: Any) {
        if envoye.isSelected == true {
            envoye.isSelected = false
            enregistre.isSelected = true
            enattente.isSelected = false
        } else if enattente.isSelected == true{
            envoye.isSelected = false
            enregistre.isSelected = true
            enattente.isSelected = false
        } else {
            enregistre.isSelected = true
            
        }
        
    }
    @IBAction func EnattenteBtn(_ sender: Any) {
        if envoye.isSelected == true {
            envoye.isSelected = false
            enregistre.isSelected = false
            enattente.isSelected = true
        } else if enregistre.isSelected == true{
            envoye.isSelected = false
            enregistre.isSelected = false
            enattente.isSelected = true
        } else {
            enattente.isSelected = true
            
        }
        
    }
    
    
    @IBAction func CreerBtn(_ sender: Any) {
        self.savefact(){success in
            if success {
                print("facture added")
                //self.dismiss(animated: true, completion: nil)
            } else {
                print("1")
                //self.resetForm()
            }}
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // print(Realm.Configuration.defaultConfiguration.fileURL)
        // Do any additional setup after loading the view.
        
    }
    
    func savefact( completion: @escaping ((_ success:Bool)->())){
        
        if envoye.isSelected {
            self.statut  = "Envoyée"
        } else if enregistre.isSelected{
            self.statut = "Enregistrée"
        } else { self.statut = "En attente" }
        let currentDate  = NSDate()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let databaseRef = Database.database().reference().child("users/facture/\(uid)/\(currentDate)")
        print(databaseRef)
        
        let newFact = [
            "client": ClientTF.text,
            "montant HT": MontantHT.text,
            "Date": currentDate.getDateString(),
            "status": self.statut
            
            ] as [String:Any]
        
        databaseRef.setValue(newFact) { error, ref in
            completion(error == nil)
        }
        
    }
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

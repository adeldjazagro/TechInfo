//
//  PopUpdateProd.swift
//  TechInfo
//
//  Created by Adel on 16/07/2019.
//  Copyright © 2019 Adel. All rights reserved.
//

import UIKit
import RealmSwift
class PopUpdateProd: UIViewController {

    
    @IBOutlet weak var nameProduitLbl: UILabel!
    
    @IBOutlet weak var quantitéLabel: UITextField!
    @IBOutlet weak var prixUnitaireLabel: UITextField!
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
   
    }
    
    @IBAction func clickUpdateBtn(_ sender: Any) {
        var nomprod = nameProduitLbl.text!
        var quantit = quantitéLabel.text!.count
        var prix = prixUnitaireLabel.text!

        let  listProd = listProduit()
        listProd.nomProd = nomprod
        listProd.quantiteProd = quantit
        listProd.prixUnit = prix
        print(Realm.Configuration.defaultConfiguration.fileURL)
        listProd.writeToRealmLP()
        self.view.removeFromSuperview()
    }
    

  

}

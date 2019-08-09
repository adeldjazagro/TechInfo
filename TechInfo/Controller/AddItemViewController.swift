//
//  AddItemViewController.swift
//  TechInfo
//
//  Created by Adel on 22/07/2019.
//  Copyright © 2019 Adel. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {

    @IBOutlet weak var nomProduitTF: UITextField!
    @IBOutlet weak var prixUnitaireTF: UITextField!
    @IBOutlet weak var quantiteTF: UITextField!
    
     var saveCompletionHandler: ((_ itemDescription: String,_ prixUnit: String,_ quant: String) -> Void)!
    
    @IBAction func saveProduct(_ sender: Any) {
        if (nomProduitTF.text?.count)! > 0 &&
            (prixUnitaireTF.text?.count)! > 0 {
            
            if saveCompletionHandler != nil {
                // Call the save completion handler to pass the item description and the price back to the CreatorViewController object.
                
                saveCompletionHandler(_ : nomProduitTF.text!, _: prixUnitaireTF.text!, _: quantiteTF.text!)
                
                // Pop the view controller.
                _ = navigationController?.popViewController(animated: true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    func presentAddItemViewControllerInViewController(originatingViewController: UIViewController, saveItemCompletionHandler: @escaping (_ itemDescription: String,_ prixUnit: String,_ quant: String) -> Void) {
        saveCompletionHandler = saveItemCompletionHandler
        originatingViewController.navigationController?.pushViewController(self, animated: true)
    }
    

   

}

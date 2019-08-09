//
//  PopUpProduitVC.swift
//  TechInfo
//
//  Created by Adel on 15/07/2019.
//  Copyright © 2019 Adel. All rights reserved.
//

import UIKit

class PopUpProduitVC: UIViewController {
 //let x = FactureTestVC()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        //x.navigationItem.hidesBackButton = true


        // Do any additional setup after loading the view.
    }
    
    @IBAction func closePopProduitBtn(_ sender: Any) {
        
        self.view.removeFromSuperview()
        //self.navigationItem.hidesBackButton = false
       // FactureTestVC.view.navigationItem.hidesBackButton = false
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

//
//  PopUpClientVC.swift
//  TechInfo
//
//  Created by Adel on 15/07/2019.
//  Copyright © 2019 Adel. All rights reserved.
//

import UIKit

class PopUpClientVC: UIViewController {

  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)

        
    }
    
    @IBAction func ClosePopClientbtn(_ sender: Any) {
        self.view.removeFromSuperview()
    }


}

//
//  RegistrationVC.swift
//  TechInfo
//
//  Created by Adel on 03/06/2019.
//  Copyright © 2019 Adel. All rights reserved.
//

import UIKit
import Foundation

class RegistrationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func NextBtn(_ sender: Any) {
        let secondRegistrationVC = storyboard?.instantiateViewController(withIdentifier: "SecondRegistrationVC") as! SecondRegistrationVC
        
        present(secondRegistrationVC, animated: true, completion: nil)
        
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

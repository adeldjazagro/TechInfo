//
//  MainVC.swift
//  TechInfo
//
//  Created by Adel on 07/05/2019.
//  Copyright © 2019 Adel. All rights reserved.
//

import UIKit
import RealmSwift

class MainVC: UIViewController {
   
    @IBOutlet weak var userName: CurrencyTextField!
    
    @IBOutlet weak var pwdTextField: CurrencyTextField!
   
    @IBAction func registrationBtn(_ sender: Any) {
        let registrationVC = storyboard?.instantiateViewController(withIdentifier: "RegistrationVC") as! RegistrationVC
        
        present(registrationVC, animated: true, completion: nil)
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      /*  print("hello world")
       let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        user.addUserToBase(nom: "adel", prenom: "mansour", email: "adeldjazagro@gmail.com", password: "coucou")*/
        
        

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginPressed(_ sender: Any) {
        let mainTabController = storyboard?.instantiateViewController(withIdentifier: "MainTabController") as! MainTabController
        
         present(mainTabController, animated: true, completion: nil)
        
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

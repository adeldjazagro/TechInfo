//
//  MainVC.swift
//  TechInfo
//
//  Created by Adel on 07/05/2019.
//  Copyright © 2019 Adel. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase

class MainVC: UIViewController {
   
    @IBOutlet weak var userName: CurrencyTextField!
    
    @IBOutlet weak var pwdTextField: CurrencyTextField!
    @IBAction func loginPressed(_ sender: Any) {
        login()
        if self.connectUser == true {
            performSegue(withIdentifier: "segue1", sender: self)
            /* let mainTabController = storyboard?.instantiateViewController(withIdentifier: "MainTabController") as! MainTabController
             
             present(mainTabController, animated: true, completion: nil)*/
        }
    }
    
    @IBAction func registrationBtn(_ sender: Any) {
        let registrationVC = storyboard?.instantiateViewController(withIdentifier: "RegistrationVC") as! RegistrationVC
        
        present(registrationVC, animated: true, completion: nil)
        
    }
    
    var connectUser = false
    override func viewDidLoad() {
        super.viewDidLoad()
      print("hello world")
      /* let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
 

        // Do any additional setup after loading the view.*/
        
    }
    
    

    
    func login(){
        guard let email = userName.text else { return}
        guard let password = pwdTextField.text else { return}
        
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if error == nil && user != nil {
                print("connected")
                self.connectUser = true
                //self.dismiss(animated: false, completion: nil)
            } else {
                print("Error logging in: \(error!.localizedDescription)")
                
                self.resetForm()
            }
        }

    }
    
    func resetForm() {
        let alert = UIAlertController(title: "Error logging in", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    
    }
    

    
    // MARK: - Navigation

    //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var maintabController = segue.destination as! MainTabController
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}

//
//  File.swift
//  TechInfo
//
//  Created by Adel on 15/05/2019.
//  Copyright © 2019 Adel. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import RealmSwift
import Realm

class MainTabController : UITabBarController {
//let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()

       //GrabData()


    /*    let dataBaseRef = Database.database().reference()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        dataBaseRef.child("users/profile").observe(.value, with: {
            snapshot  in
            print(snapshot)
            for snap in snapshot.children.allObjects as! [DataSnapshot]{
                guard let dict = snap.value as? [String : AnyObject] else {
                    return
                }
               let a = snap.key
               if a == uid {
                print(a)
                print(dict["first Name"] as! String)
                let use = user()
                use.id_user = a
                use.nom = dict["family Name"] as! String
                use.prenom  = dict["first Name"] as! String
                use.email =  dict["bank Account"] as! String
                //print("bonjour \(use.email)")
               /* var na = use.nom
                var pren = use.prenom
                var mail = use.email*/
             //  user.addUserToBase(id_user: uid, nom: dict["family Name"] as! String, prenom: dict["first Name"] as! String, email: dict["bank Account"] as! String)
                //let realm = try! Realm()

                print(Realm.Configuration.defaultConfiguration.fileURL)

                    use.writeToRealm()
                }}
           

        })
    
     */
    }
  
    
}

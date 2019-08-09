//
//  FirstViewController.swift
//  TechInfo
//
//  Created by Adel on 07/05/2019.
//  Copyright © 2019 Adel. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift

class FirstViewController: UIViewController {
     let uid = Auth.auth().currentUser?.uid
    var trans : Results<transactions>!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GrabData()
        tableView.delegate = self as UITableViewDelegate
        tableView.dataSource = self as UITableViewDataSource
    }
    
    func  GrabData() {
        let dataBaseRef = Database.database().reference()
        guard  let id = Auth.auth().currentUser?.uid else {
            return
        }
        dataBaseRef.child("users/transaction/\(id)").observe(.value, with: {
            snapshot  in
            print(snapshot)
            for snap in snapshot.children.allObjects as! [DataSnapshot]{
                guard let dictionary = snap.value as? [String : AnyObject] else {
                    return
                }
                var date = snap.key
                var montant = dictionary["montant"] as! Double
                var libelle = dictionary["libelle"] as! String
                var id_user = self.uid
                var self_id = "\(date)\(id)"
                //var id = dictionary["id"] as? String
                //var username = dictionary["username"] as? String
                //var adress = dictionary["adress"] as? String
                
                let trans = transactions()
                trans.date = date
                trans.montant_trans = montant
                trans.id_trans = self_id
                trans.libelle = libelle
                trans.id_user = id_user!
                //use.id = id
                // use.username = username
                //use.adress = adress
                
                print(Realm.Configuration.defaultConfiguration.fileURL)
                
                trans.writeToRealme()
                
                self.reloadData()
                
            }
            
            
        })
        
        
    }
    func reloadData() {
        trans = uiRealm.objects(transactions.self).filter("id_user = '\(uid!)'")
        self.tableView.reloadData()

    }


}

extension FirstViewController: UITableViewDelegate, UITableViewDataSource{
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if trans != nil {
        return trans.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell") as? TransactionCell {
            guard let transs = trans?[indexPath.row] else {
                return TransactionCell()
            }
            cell.configure(trans: transs)
            return cell
        } else {
            return TransactionCell()
        }
        
    }
    
}

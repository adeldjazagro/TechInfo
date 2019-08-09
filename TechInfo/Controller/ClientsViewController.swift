//
//  ClientsViewController.swift
//  TechInfo
//
//  Created by Adel on 02/08/2019.
//  Copyright © 2019 Adel. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift
import Realm




class ClientsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let uid = Auth.auth().currentUser?.uid
    var clients = [client]()
    var searchClient = [client]()
    var searching = false

    

    

    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func AddBtn(_ sender: Any) {

        performSegue(withIdentifier: "segueAddClient", sender: self)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        GrabData()

        // Do any additional setup after loading the view.
    }
    func  GrabData() {
        let dataBaseRef = Database.database().reference()
        guard  let id = Auth.auth().currentUser?.uid else { return }
        dataBaseRef.child("users/client/\(id)").observe(.value, with: {
            snapshot  in
            print(snapshot)
            for snap in snapshot.children.allObjects as! [DataSnapshot]{
                guard let dictionary = snap.value as? [String : AnyObject] else {
                    return
                }
                var id_client = snap.key
                var nom = dictionary["nom"] as! String
                var prenom = dictionary["prenom"] as! String
                var id_utilisateur = id
                var adress_client = dictionary["adress"] as! String
                var email_client = dictionary["email"] as! String
                var phone_client = dictionary["phone"] as! String

                
                let cl = client()
                cl.id_client = id_client
                cl.nom_client = nom
                cl.prenom_client = prenom
                cl.adresse_client = adress_client
                cl.email_client = email_client
                cl.phone_client = phone_client
                cl.id_utilisateur = id_utilisateur
                
                print(Realm.Configuration.defaultConfiguration.fileURL)
                
                cl.writeToRealme()
                
                
            }
            self.reloadData()

            
            
        })
        
        
    }
    
    func reloadData() {
        var res = uiRealm.objects(client.self).filter("id_utilisateur = '\(uid!)'")
        self.clients.removeAll()

        for each in res {
            self.clients.append(each)
            print(each)
        }
        self.tableView.reloadData()
        
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchClient.count
        } else {
            return clients.count
        }
       // return clients.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "clientCell"))!
        if searching {
            cell.textLabel?.text = "\(searchClient[indexPath.row].nom_client) \(searchClient[indexPath.row].prenom_client)"

        } else {
            cell.textLabel?.text = "\(clients[indexPath.row].nom_client) \(clients[indexPath.row].prenom_client)"

        }
       // cell.textLabel?.text = "\(clients[indexPath.row].nom_client) \(clients[indexPath.row].prenom_client)"
        
        return cell
    }
   

}

extension ClientsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       /* searchClient = clients.filter({clients -> Bool in
            guard let text = SearchBar.text else { return false}
            return clients.nom_client.contains(text)
        } )
        searching = true
        tableView.reloadData()*/
        self.searchClient.removeAll()
        let realm = try! Realm()
        var res = uiRealm.objects(client.self).filter("id_utilisateur = '\(uid!)'")

        let predicate = NSPredicate(format: "nom_client CONTAINS [c] %@ OR prenom_client CONTAINS [c] %@", searchText, searchText)
        var x = res.filter(predicate)
        for each in x {
            self.searchClient.append(each)
        }
        searching = true
        tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}



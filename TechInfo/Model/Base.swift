//
//  Base.swift
//  TechInfo
//
//  Created by Adel on 09/05/2019.
//  Copyright © 2019 Adel. All rights reserved.
//

import Foundation
import RealmSwift

class user : Object {
    @objc dynamic   var id_user = ""
    @objc dynamic   var nom = ""
    @objc dynamic   var prenom = ""
    @objc dynamic   var pwd_user = "" // mettre en md5
    @objc dynamic   var email = ""
    @objc dynamic   var owner : cat_user!
    @objc dynamic   var compte_user: compte!
    
    let clients = List<client>()
    let produits = List<produit>()
    let factures = List<facture>()
    let employes = List<employe>()
    let devi = List<devis>()
    let notes = List<note_frais>()
    


    override static func primaryKey() -> String? {
        return "id_user"
    }
    
    convenience init(nom: String, prenom: String, email: String,password: String) {
        self.init()
        self.id_user = UUID().uuidString.lowercased()
        self.nom = nom
        self.prenom = prenom
        self.email = email
        self.pwd_user = password
    }
    
    static func addUserToBase(nom: String, prenom: String, email: String, password: String){
        let per = user(nom: nom, prenom: prenom, email: email, password: password )
        
        do{
            let realm = try! Realm()

            try realm.write {
                realm.add(per)
            }
        } catch {
            debugPrint("error adding user to base")
        }
    }
    
    static func addClientToUser(_use: user, clein: client){
        let clnt = clein
        do{
            let realm = try! Realm()
            try realm.write {
                _use.clients.append(clnt)
            }
        } catch {
            debugPrint("error adding user to base")
        }
    }
    
    static func addProductToUser(_use: user, prod: produit){
        do{
            let realm = try! Realm()
            try realm.write {
                _use.produits.append(prod)
            }
        } catch {
            debugPrint("error adding user to base")
        }
    }
    
    static func addFactureToUser(_use: user, fact: facture){
        do{
            let realm = try! Realm()
            try realm.write {
                _use.factures.append(fact)
            }
        } catch {
            debugPrint("error adding user to base")
        }
    }
    
    static func addEmployeToUser(_use: user, emp: employe){
        do{
            let realm = try! Realm()
            try realm.write {
                _use.employes.append(emp)
            }
        } catch {
            debugPrint("error adding user to base")
        }
    }
    
    static func addDevisToUser(_use: user, devi: devis){
        do{
            let realm = try! Realm()
            try realm.write {
                _use.devi.append(devi)
            }
        } catch {
            debugPrint("error adding user to base")
        }
    }
    
    static func addNoteToUser(_use: user, note: note_frais){
        do{
            let realm = try! Realm()
            try realm.write {
                _use.notes.append(note)
            }
        } catch {
            debugPrint("error adding user to base")
        }
    }
}

class cat_user : Object {
    @objc dynamic   var id_cat = ""
    @objc dynamic   var libelle = ""
    let users = List<user>()
    
    override static func primaryKey() -> String? {
        return "id_cat"
    }
    
    static func addUserToCat(_cat_user: cat_user, use: user){
        do{
            let realm = try! Realm()
            try realm.write {
                _cat_user.users.append(use)
            }
        } catch {
            debugPrint("error adding user to base")
        }
    }
    
    
    
}

class client : Object {
    @objc dynamic   var id_client = ""
    @objc dynamic   var nom_client = ""
    @objc dynamic   var prenom_client = ""
    @objc dynamic   var adresse_client = ""
    
    @objc dynamic   var owner : user!
    
    override static func primaryKey() -> String? {
        return "id_client"
    }
    
    convenience init(nom: String, prenom: String, adresse: String) {
        self.init()
        self.id_client = UUID().uuidString.lowercased()
        self.nom_client = nom
        self.prenom_client = prenom
        self.adresse_client = adresse
    }

    
    
}

class produit : Object {
    @objc dynamic   var id_produit = ""
    @objc dynamic   var libelle_produit = ""
    @objc dynamic   var prix_unit = 0.0
    
    @objc dynamic   var owner : user!
    let fact = List<facture>()

    override static func primaryKey() -> String? {
        return "id_produit"
    }
    convenience init(libelle: String, prix: Double) {
        self.init()
        self.id_produit = UUID().uuidString.lowercased()
        self.libelle_produit = libelle
        self.prix_unit = prix
    }
    
    static func addFactutreToProduit(_prod: produit, factur: facture){
        do{
            let realm = try! Realm()
            try realm.write {
                _prod.fact.append(factur)
            }
        } catch {
            debugPrint("error adding user to base")
        }
    }
    
    
}

class facture : Object {
    @objc dynamic   var id_facture = ""
    @objc dynamic   var date_fact = NSDate()
    @objc dynamic   var montant_ttc = 0.0
    @objc dynamic   var montant_ht = 0.0
    
    let products = List<produit>()
    @objc dynamic   var owner : user!

    override static func primaryKey() -> String? {
        return "id_facture"
    }
    
    convenience  init(montant_ttc: Double, montant_ht: Double) {
        self.init()
        self.id_facture = UUID().uuidString.lowercased()
        self.date_fact = NSDate()
        self.montant_ttc = montant_ttc
        self.montant_ht = montant_ht
    }
    
    static func addProduitToFcature(_fact: facture, prod: produit){
        do{
            let realm = try! Realm()
            try realm.write {
                _fact.products.append(prod)
            }
        } catch {
            debugPrint("error adding user to base")
        }
    }
    
}

class note_frais : Object {
    @objc dynamic   var id_note = ""
    @objc dynamic   var date_note = NSDate()
    @objc dynamic   var montant_ttc = 0.0
    @objc dynamic   var montant_ht = 0.0
    @objc dynamic   var motif = ""
    @objc dynamic   var owner : user!
    
    override static func primaryKey() -> String? {
        return "id_note"
    }
    
    convenience  init(montant_ttc: Double, montant_ht: Double,motif: String) {
        self.init()
        self.id_note = UUID().uuidString.lowercased()
        self.date_note = NSDate()
        self.montant_ttc = montant_ttc
        self.montant_ht = montant_ht
        self.motif = motif
    }
    
    
}

class devis : Object {
    @objc dynamic   var id_devis = ""
    @objc dynamic   var date_devis = NSDate()
    @objc dynamic   var montant_ttc = 0.0
    @objc dynamic   var montant_ht = 0.0
    
    let products = List<produit>()
    @objc dynamic   var owner : user!
    
    override static func primaryKey() -> String? {
        return "id_devis"
    }
    
    convenience  init(montant_ttc: Double, montant_ht: Double) {
        self.init()
        self.id_devis = UUID().uuidString.lowercased()
        self.date_devis = NSDate()
        self.montant_ttc = montant_ttc
        self.montant_ht = montant_ht
    }
    
    static func addProduitToDevis(_devis: facture, prod: produit){
        do{
            let realm = try! Realm()
            try realm.write {
                _devis.products.append(prod)
            }
        } catch {
            debugPrint("error adding user to base")
        }
    }
    
    
}

class compte : Object {
    @objc dynamic   var id_compte = ""
    @objc dynamic   var pwd_compte = "" // mettre en md5
    @objc dynamic   var owner : user!
    let sold = List<sold_compte>()
    let trans = List<transactions>()
    
    override static func primaryKey() -> String? {
        return "id_compte"
    }
    
    convenience  init(pwd_comprte: String) {
        self.init()
        self.id_compte = UUID().uuidString.lowercased()
        self.pwd_compte = pwd_comprte
    }
    
    static func addSoldeToCompte(_cpt: compte, sold: sold_compte){
        do{
            let realm = try! Realm()
            try realm.write {
                _cpt.sold.append(sold)
            }
        } catch {
            debugPrint("error adding user to base")
        }
    }
    static func addTransToCompte(_cpt: compte, trans: transactions){
        do{
            let realm = try! Realm()
            try realm.write {
                _cpt.trans.append(trans)
            }
        } catch {
            debugPrint("error adding user to base")
        }
    }
    
}

class sold_compte : Object {
    @objc dynamic   var id = ""
    @objc dynamic   var date = NSDate()
    @objc dynamic   var sold_compte = 0.0
    @objc dynamic   var owner: compte!
    

    
    func setCompoundID(id: String) {
        self.id = id
        compoundKey = compoundKeyValue()
    }

    func setCompoundDate(date: NSDate) {
        self.date = date
        compoundKey = compoundKeyValue()
    }
    
    dynamic lazy var compoundKey: String = self.compoundKeyValue()
    
    override static func primaryKey() -> String? {
        return "compoundKey"
    }
    
    func compoundKeyValue() -> String {
        return "\(id)\(date)"
    }
    
    convenience  init(sold_compte: Double) {
        self.init()
        self.id = owner.id_compte
        self.date = NSDate()
        self.sold_compte = sold_compte
    }
    
}

class transactions : Object {
    
    @objc dynamic   var id_trans = ""
    @objc dynamic   var date = NSDate()
    @objc dynamic   var montant_trans: Double = 0.0
    @objc dynamic   var owner: compte!

    
    
    
    func setCompoundID(id_trans: String) {
        self.id_trans = id_trans
        compoundKey = compoundKeyValue()
    }
    
    func setCompoundDate(date: NSDate) {
        self.date = date
        compoundKey = compoundKeyValue()
    }
    
    dynamic lazy var compoundKey: String = self.compoundKeyValue()
    
    override static func primaryKey() -> String? {
        return "compoundKey"
    }
    
    func compoundKeyValue() -> String {
        return "\(id_trans)\(date)"
    }
    
    convenience  init(montant_trans: Double) {
        self.init()
        self.id_trans = UUID().uuidString.lowercased()
        self.date = NSDate()
        self.montant_trans = montant_trans
        
    }
    
}

class employe : Object {
    @objc dynamic   var id_emp = ""
    @objc dynamic   var num_sec = ""
    @objc dynamic   var nom_emp = ""
    @objc dynamic   var prenom_emp = ""
    @objc dynamic   var nbe_heures = 0.0
    @objc dynamic   var sal_brut = 0.0
    
    var employe = LinkingObjects(fromType: user.self, property: "employes")
    var grade = LinkingObjects(fromType: grade_emp.self, property: "emp")
    
    override static func primaryKey() -> String? {
        return "id_emp"
    }
    
    convenience init(nom: String, prenom: String, num_securite: String, nbe_heures: Double, sal_brut: Double) {
        self.init()
        self.id_emp = UUID().uuidString.lowercased()
        self.nom_emp = nom
        self.prenom_emp = prenom
        self.num_sec = num_securite
        self.nbe_heures = nbe_heures
        self.sal_brut = sal_brut
    }

    

}

class grade_emp : Object{
    @objc dynamic   var num_grad = ""
    @objc dynamic   var libelle_grad = ""
    @objc dynamic   var taux_cot = 0.0
    
    let emp = List<employe>()
    
    override static func primaryKey() -> String? {
        return "num_grad"
    }
    
    convenience  init(lobelle_grad: String, taux_cot: Double) {
        self.init()
        self.num_grad = UUID().uuidString.lowercased()
        self.libelle_grad = libelle_grad
        self.taux_cot = taux_cot
        
    }
    
    static func addEmployeToGrade(_grad: grade_emp, emp: employe){
        do{
            let realm = try! Realm()
            try realm.write {
                _grad.emp.append(emp)
            }
        } catch {
            debugPrint("error adding user to base")
        }
    }
    
}

class heures_travail : Object {
    @objc dynamic   var num_emp = ""
    @objc dynamic   var date = NSDate()
    @objc dynamic   var heures = 0.0
    @objc dynamic   var owner: employe!
    
    
    
    func setCompoundID(id_emp: String) {
        self.num_emp = id_emp
        compoundKey = compoundKeyValue()
    }
    
    func setCompoundDate(date: NSDate) {
        self.date = date
        compoundKey = compoundKeyValue()
    }
    
    dynamic lazy var compoundKey: String = self.compoundKeyValue()
    
    override static func primaryKey() -> String? {
        return "compoundKey"
    }
    
    func compoundKeyValue() -> String {
        return "\(num_emp)\(date)"
    }
    
    
    convenience  init(heures: Double) {
        self.init()
        self.num_emp = owner.id_emp
        self.date = NSDate()
        self.heures = heures
        
        
    }
    
}

//
//  FactureTestVC.swift
//  TechInfo
//
//  Created by Adel on 15/07/2019.
//  Copyright © 2019 Adel. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class FactureTestVC: UIViewController , UITableViewDelegate , UITableViewDataSource{

   
 //   var client = ["Samir Bouzid", "Adel Mansour","Tarik Yazid"]
   // var produit = ["Xiaomi", "OnePlus","Samsung", "Huawei", "Apple"]

    var items: [[String: String]]!
   
    var invoiceNumber: String!
    
    var saveCompletionHandler: ((_ invoiceNumber: String, _ recipientInfo: String,_ totalAmount: String, _ items: [[String: String]]) -> Void)!
    
    var firstAppeared = true
    var nextNumberAsString: String!


    
    @IBOutlet weak var infoClientTF: UITextView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var clientsBtn: UIButton!
    
    @IBOutlet weak var bbiTotal: UIBarButtonItem!
    
    var prix = "0"
    var totalAmount = "0"
    var numItem = 0
    var nuItemString = "0"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        //var fact = facture()

       
    }
    
    @IBAction func saveInvoice(_ sender: AnyObject) {
        if saveCompletionHandler != nil {
            if nextNumberAsString != nil {
                UserDefaults.standard.set(nextNumberAsString, forKey: "nextInvoiceNumber")
            }
            else {
                UserDefaults.standard.set("002", forKey: "nextInvoiceNumber")
            }
            
            saveCompletionHandler(_: invoiceNumber, _: infoClientTF.text, _: bbiTotal.title!, _: items)
            _ = navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if firstAppeared {
            determineInvoiceNumber()
            displayTotalAmount()
            firstAppeared = false
        }
    }
    
    
    @IBAction func addProduct(_ sender: Any) {
        let addItemViewController = storyboard?.instantiateViewController(withIdentifier: "idAddProduct") as! AddItemViewController
        addItemViewController.presentAddItemViewControllerInViewController(originatingViewController: self) { (itemDescription, prixUnit, quant) in
         
            DispatchQueue.main.async {
                if self.items == nil {
                    self.items = [[String: String]]()
                }
                let mont = NumberFormatter().number(from: quant)
                let mont2 = NumberFormatter().number(from: prixUnit)
                let mont3 = Double(truncating: mont!) * Double(truncating: mont2!)
                self.prix = String(mont3)
                
                self.numItem = self.numItem + 1
                self.nuItemString = String(self.numItem)
                self.items.append(["item": itemDescription,"Quantite": quant,"Prix Unitaire": prixUnit,"price": self.prix,"N°": self.nuItemString])
                self.tableView.reloadData()
                
               self.displayTotalAmount()
            }
        }
    }
    


    func determineInvoiceNumber() {
        // Get the invoice number from the user defaults if exists.
        if let nextInvoiceNumber = UserDefaults.standard.object(forKey: "nextInvoiceNumber") {
            invoiceNumber = nextInvoiceNumber as? String
            
            // Save the next invoice number to the user defaults.
            let nextNumber = Int(nextInvoiceNumber as! String)! + 1
            
            if nextNumber < 10 {
                nextNumberAsString = "00\(nextNumber)"
            }
            else if nextNumber < 100 {
                nextNumberAsString = "0\(nextNumber)"
            }
            else {
                nextNumberAsString = "\(nextNumber)"
            }
        }
        else {
            // Specify the first invoice number.
            invoiceNumber = "001"
            // Set the invoice number to the navigation bar's title.
            navigationItem.title = invoiceNumber
        }
        
       
    }
    
    
    func calculateTotalAmount() {
        var total: Double = 0.0
        if items != nil {
            for invoiceItem in items {
                let priceAsNumber = NumberFormatter().number(from: invoiceItem["price"]!)
                total += Double(truncating: priceAsNumber!)
            }
        }
        
        totalAmount = AppDelegate.getAppDelegate().getStringValueFormattedAsCurrency(value: "\(total)")
    }
    
    
    func displayTotalAmount() {
        calculateTotalAmount()
        bbiTotal.title = totalAmount
    }
    
    func presentCreatorViewControllerInViewController(originalViewController: UIViewController, saveCompletionHandler: @escaping (_ invoiceNumber: String, _ recipientInfo: String,_ totalAmount: String, _ items: [[String: String]]) -> Void) {
        self.saveCompletionHandler = saveCompletionHandler
        originalViewController.navigationController?.pushViewController(self, animated: true)
            
        
          //  self.resetForm()
        
    }
  
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if items != nil {
            return items.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
    
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "produitCell") as? ProduitViewCell
   
        
      if cell == nil {
        return ProduitViewCell()
        //cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "produitCell")
        }
        
        cell?.nomProduit.text = items[indexPath.row]["item"]!
        cell?.prixUnitaireProduit.text = AppDelegate.getAppDelegate().getStringValueFormattedAsCurrency(value: items[indexPath.row]["Prix Unitaire"]!)
        cell?.quantiteProduit.text = items[indexPath.row]["Quantite"]!
        
        
        
        return cell!
    }
    
    
    /* @IBAction func clickProduitBtn(_ sender: Any) {
        if tableViewProduit.isHidden{
            animate2(toggle: true)
        } else {
            animate2(toggle: false)
        }
        
    }
    @IBAction func clickClientbtn(_ sender: Any) {
        if tableViewClient.isHidden{
            animate(toggle: true)
        } else {
            animate(toggle: false)
        }
        
    }
    func animate(toggle: Bool){
        if toggle{
            UIView.animate(withDuration: 0.3){
                self.tableViewClient.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 0.3){
                self.tableViewClient.isHidden = true
            }
        }
    }
    
    func animate2(toggle: Bool){
        if toggle{
            UIView.animate(withDuration: 0.3){
                self.tableViewProduit.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 0.3){
                self.tableViewProduit.isHidden = true
            }
        }
    }
    
    @IBAction func showPopClientBtn(_ sender: Any) {
        let popClient = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopClientId") as! PopUpClientVC
        self.addChild(popClient)
        popClient.view.frame = self.view.frame
        self.view.addSubview(popClient.view)
        
        popClient.didMove(toParent: self)
        
    }
    
    
    func goToPopUpProd() {
        let popUpdateProd = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popUpdate") as! PopUpdateProd
        self.addChild(popUpdateProd)
        popUpdateProd.view.frame = self.view.frame
        self.view.addSubview(popUpdateProd.view)
        popUpdateProd.didMove(toParent: self)
        
    }
    
    @IBAction func showPopProduitBtn(_ sender: Any) {
        let popProduit = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopProduitID") as! PopUpProduitVC
        self.addChild(popProduit)
        //CGSize size = CGSizeMake(411, 400)
        popProduit.view.frame = CGRect(x: 0, y: 0, width: popProduit.view.bounds.width, height: popProduit.view.bounds.height)
        self.view.addSubview(popProduit.view)
        popProduit.didMove(toParent: self)
        //self.navigationItem.hidesBackButton = true
    }
    

}

extension FactureTestVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1{
        return (client.count)
        } else if tableView.tag == 2 {
            return produit.count
        } else {
            return 0
        }
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if tableView.tag == 1 {
            cell.textLabel?.text = client[indexPath.row]
        } else if tableView.tag == 2 {
            cell.textLabel?.text = produit[indexPath.row]
        }
        return cell
}
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag == 1 {
        clientBtn.setTitle("\(client[indexPath.row])", for: .normal)
            animate(toggle: false)
        } else if tableView.tag == 2 {
            let listfact = listProduit()
            listfact.nomProd = produit[indexPath.row]
            //produitClient.setTitle("\(produit[indexPath.row])", for: .normal)
            goToPopUpProd()
            animate2(toggle: false)
        }
    }*/



}

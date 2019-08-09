//
//  NoteVC.swift
//  TechInfo
//
//  Created by Adel on 04/06/2019.
//  Copyright © 2019 Adel. All rights reserved.
//

import UIKit
import RealmSwift


class FactureVC: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet var tablView: UITableView!
   
   public var invoices: [[String: AnyObject]]!
    
    var selectedInvoiceIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tablView.delegate = self
        tablView.dataSource = self

       
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let inv = UserDefaults.standard.object(forKey: "invoices") {
            invoices = inv as? [[String: AnyObject]]
            tablView.reloadData()
        }
    }
   @IBAction func createInvoice(_ sender: Any) {
        
        let creatorViewController = storyboard?.instantiateViewController(withIdentifier: "idCreateInvoice") as! FactureTestVC
        creatorViewController.presentCreatorViewControllerInViewController(originalViewController: self) { (invoiceNumber, recipientInfo, totalAmount, items) in
            DispatchQueue.main.async {
                if self.invoices == nil {
                    self.invoices = [[String: AnyObject]]()
                 
                }

                // Add the new invoice data to the invoices array.

                self.invoices.append([ "invoiceDate": self.formatAndGetCurrentDate() as AnyObject, "invoiceNumber": invoiceNumber as AnyObject, "recipientInfo": recipientInfo as AnyObject, "totalAmount": totalAmount as AnyObject, "items": items as AnyObject])
                // Update the user defaults with the new invoice.
                UserDefaults.standard.set(self.invoices, forKey: "invoices")
                // Reload the tableview.
                self.tablView.reloadData()
            }
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "idSeguePresentPreview" {
                let previewViewController = segue.destination as! PreviewViewController
                previewViewController.invoiceInfo = invoices[selectedInvoiceIndex]
            }
        }
    }
    
    
   
    func formatAndGetCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        return dateFormatter.string(from: NSDate() as Date)
    }
    
    func formatAndGetCurrentTime() -> String {
       let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .none
        return formatter.string(from: currentDateTime)
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if invoices != nil {
            return invoices.count
        } else {
            return 0
        }
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "factureCell") as? FactureCell
        
        
        if cell == nil {
            return cell!
            //cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "produitCell")
        }
        
        cell?.invoiceNumLbl.text = invoices[indexPath.row]["invoiceNumber"] as! String
        cell?.dateLbl.text = invoices[indexPath.row]["invoiceDate"] as! String
        cell?.montantLbl.text = invoices[indexPath.row]["totalAmount"] as! String
        
        
        return cell!
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedInvoiceIndex = indexPath.row
        performSegue(withIdentifier: "idSeguePresentPreview", sender: self)
    }
    
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            invoices.remove(at: indexPath.row)
            tablView.reloadData()
            UserDefaults.standard.set(self.invoices, forKey: "invoices")
        }
    }
    
    
  
}

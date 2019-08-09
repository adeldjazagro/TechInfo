//
//  TransactionCell.swift
//  TechInfo
//
//  Created by Adel on 17/05/2019.
//  Copyright © 2019 Adel. All rights reserved.
//

import UIKit

class TransactionCell: UITableViewCell {
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var montantLbl: UILabel!
    @IBOutlet weak var libelleLbl: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(trans: transactions){
        dateLbl.text = trans.date
        montantLbl.text = "\(trans.montant_trans) €"
        libelleLbl.text = trans.libelle
    }



}

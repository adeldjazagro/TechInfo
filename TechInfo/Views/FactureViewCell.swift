//
//  FactureViewCellTableViewCell.swift
//  TechInfo
//
//  Created by Adel on 15/07/2019.
//  Copyright © 2019 Adel. All rights reserved.
//

import UIKit

class FactureViewCell: UITableViewCell {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var heureFact: UILabel!
    @IBOutlet weak var numFact: UILabel!
    @IBOutlet weak var montantLbl: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(fact: facture){
        dateLbl.text = fact.date_fact as? String
        montantLbl.text = "\(fact.montant_ht) €"
        numFact.text = fact.client
        heureFact.text = fact.status
    }

}

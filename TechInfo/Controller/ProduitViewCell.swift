//
//  ProduitViewCell.swift
//  TechInfo
//
//  Created by Adel on 16/07/2019.
//  Copyright © 2019 Adel. All rights reserved.
//

import UIKit

class ProduitViewCell: UITableViewCell {

    
    
    
    @IBOutlet weak var nomProduit: UILabel!
    @IBOutlet weak var quantiteProduit: UILabel!
    @IBOutlet weak var prixUnitaireProduit: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  


}

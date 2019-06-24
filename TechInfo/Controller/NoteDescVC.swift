//
//  FactDescVC.swift
//  TechInfo
//
//  Created by Adel on 28/05/2019.
//  Copyright © 2019 Adel. All rights reserved.
//

import UIKit

class NoteDescVC: UIViewController {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLbl.text = tap[myIndex]
        descLbl.text = tapDetail[myIndex]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

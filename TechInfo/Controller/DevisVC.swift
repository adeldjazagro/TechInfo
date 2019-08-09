//
//  DevisVC.swift
//  TechInfo
//
//  Created by Adel on 04/06/2019.
//  Copyright © 2019 Adel. All rights reserved.
//

import UIKit
import RealmSwift
import Realm
import Realm.Dynamic


class DevisVC: UITableViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
         print(Realm.Configuration.defaultConfiguration.fileURL!)
        // Do any additional setup after loading the view.
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

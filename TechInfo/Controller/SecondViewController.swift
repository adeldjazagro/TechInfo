//
//  SecondViewController.swift
//  TechInfo
//
//  Created by Adel on 07/05/2019.
//  Copyright © 2019 Adel. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var FactureVC: UIView!
    
    @IBOutlet weak var NoteVC: UIView!
    
    @IBOutlet weak var DevisVC: UIView!
    
    @IBOutlet weak var FactureBtn: UIButton!
    
    @IBOutlet weak var NoteBtn: UIButton!
    @IBOutlet weak var DevisBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func swithBnt(_ sender: UISegmentedControl) {
        
            if sender.selectedSegmentIndex == 0 {
                FactureVC.alpha = 1
                DevisVC.alpha = 0
                NoteVC.alpha = 0
                NoteBtn.isHidden = true
                DevisBtn.isHidden = true
                FactureBtn.isHidden = false

            } else if sender.selectedSegmentIndex == 1 {
                FactureVC.alpha = 0
                DevisVC.alpha = 0
                NoteVC.alpha = 1
                FactureBtn.isHidden = true
                DevisBtn.isHidden = true
                NoteBtn.isHidden = false

            } else if sender.selectedSegmentIndex == 2 {
                FactureVC.alpha = 0
                DevisVC.alpha = 1
                NoteVC.alpha = 0
                FactureBtn.isHidden = true
                NoteBtn.isHidden = true
                DevisBtn.isHidden = false



            }
            
        
    }
}



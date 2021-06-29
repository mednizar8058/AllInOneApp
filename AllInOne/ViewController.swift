//
//  ViewController.swift
//  AllInOne
//
//  Created by MNizar on 6/20/21.
//  Copyright © 2021 MNizar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    


    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var StudentManView: UIView!
    @IBOutlet weak var First: UIButton!
    
    @IBOutlet weak var Second: UIButton!
    
    @IBOutlet weak var Third: UIButton!
    
    @IBOutlet weak var Forth: UIButton!
    
    @IBOutlet weak var Fifth: UIButton!
    
    @IBOutlet weak var Sixth: UIButton!
    
    @IBOutlet weak var Seventh: UIButton!
    
    @IBOutlet weak var eighth: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareMenu()
        
        
        // Do any additional setup after loading the view.
    }
    
    func prepareMenu(){
        First.layer.cornerRadius = 20
        Second.layer.cornerRadius = 20
        Third.layer.cornerRadius = 20
        Forth.layer.cornerRadius = 20
        Fifth.layer.cornerRadius = 20
        Sixth.layer.cornerRadius = 20
        Seventh.layer.cornerRadius = 20
        eighth.layer.cornerRadius = 20
        
        StudentManView.layer.cornerRadius = 20
        headerView.layer.cornerRadius = 30
        profileImg.layer.cornerRadius = 37
        
    }


}


//
//  SideMenuViewController.swift
//  AllInOne
//
//  Created by MNizar on 6/20/21.
//  Copyright © 2021 MNizar. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {

    
    @IBOutlet weak var ProfileImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isHidden = true
        prepareSideMenu()

        // Do any additional setup after loading the view.
    }
    
    
    func prepareSideMenu(){
        ProfileImg.layer.cornerRadius = 40
        ProfileImg.clipsToBounds = true
    }
    
    @IBAction func didClickSideMenuBtn(_ sender: UIButton) {
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

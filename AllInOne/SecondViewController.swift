//
//  SecondViewController.swift
//  AllInOne
//
//  Created by MNizar on 6/20/21.
//  Copyright © 2021 MNizar. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        img.image = UIImage(named: "starEmpty")

        // Do any additional setup after loading the view.
    }
    
    var timer = Timer()
    var cpt = 0
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    


    @IBAction func playTimer(_ sender: UIBarButtonItem) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(display), userInfo:nil, repeats: true)
    }
    
    @IBAction func pauseTimer(_ sender: UIBarButtonItem) {
        timer.invalidate()
    }
    
    @IBAction func resetTimer(_ sender: UIBarButtonItem) {
        timer.invalidate()
        cpt = 0
        label.text = "0"
        img.image = UIImage(named: "starEmpty")
        
    }
    
    @objc func display(){
        cpt+=1
        label.text = String(cpt)
        if cpt%2 == 0{
            img.image = UIImage(named: "starEmpty")
        }
        else{
            img.image = UIImage(named: "starFilled")

        }
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

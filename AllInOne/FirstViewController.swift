//
//  FirstViewController.swift
//  AllInOne
//
//  Created by MNizar on 6/20/21.
//  Copyright © 2021 MNizar. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        magicNumber = Int(arc4random_uniform(10))
        nbrTries.text = ""
        indicationText.text = ""
        guessBtn.layer.cornerRadius = 7

        

        // Do any additional setup after loading the view.
    }
    var magicNumber:Int = 0
    var msg:String = "Bravoo !"
    var counter:Int = 0
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var indicationText: UILabel!
    @IBOutlet weak var nbrTries: UILabel!
    
    @IBOutlet weak var guessBtn: UIButton!
    @IBAction func deviner(_ sender: Any) {
        
        

        let guessNumber = Int(input.text!)!
        let alert = UIAlertController(title: "Résultat", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style:.default , handler: nil)
        alert.addAction(action)
        counter+=1
        nbrTries.text = "Nombre de jeux : \(counter)"
        
        if guessNumber > magicNumber{
            indicationText.text = "indication : Donner un numéro plus petit"
            
            
        }
        else if guessNumber == magicNumber{
            indicationText.text = "Bravooo !"
            self.present(alert, animated: false)
        }
        else{
            indicationText.text = "indication : Donner un numéro plus grand"
        }
    }
    
    
    @IBAction func rejouer(_ sender: Any) {
        input.text = ""
        indicationText.text = ""
        counter = 0
        nbrTries.text = ""
        magicNumber = Int(arc4random_uniform(10))
    }

    

}

//
//  ForthViewController.swift
//  AllInOne
//
//  Created by MNizar on 6/20/21.
//  Copyright © 2021 MNizar. All rights reserved.
//

import UIKit

class ForthViewController: UIViewController {
    
    var weight:Float = 0
    var height:Float = 0
        
        
    struct IMC{
        var height:Float
        var weight:Float
        var value:Float{
            get{
                
                return weight/pow(height,2)
            }
        }
        
        var color:UIColor{
            get{
                return calculate().1
            }
        }
        var description:String{
            get{
                return calculate().0
            }
        }
        
        func calculate() -> (String,UIColor){
            switch value {
            case 18.5..<25:
                return("Poids normale",.green)
            case 25..<30:
                return("Surpoids",.yellow)
            case 30..<35:
                return("Obésité modéré",.orange)
            case 35..<40:
                return("Obésité sévère",.red)
            case 40..<200:
                return("Obésité massive",.brown)
            default:
                return("valeur not indicated",.gray)
            }
        }
    }
    
    
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightlbl: UILabel!
    @IBOutlet weak var heightlbl: UILabel!
    
    @IBOutlet weak var heightUnit: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateBtb.layer.cornerRadius = 10
    }
    
    @IBOutlet weak var calculateBtb: UIButton!
    
    @IBAction func changeWeight(_ sender: UISlider) {
        weightlbl.text = String(Int(sender.value))
        weight = sender.value
    }
    
    @IBAction func changeHeight(_ sender: UISlider) {
        if(heightUnit.selectedSegmentIndex == 1){
            sender.maximumValue = 300
            heightlbl.text = String(Int(sender.value))

                
        }
        else{
            sender.maximumValue = 3
            heightlbl.text = String(format : "%0.2f",Float(sender.value))
            

        }
        height = sender.value
        
    }
    
    func calculate() ->IMC {
        if(heightUnit.selectedSegmentIndex == 1){
            height = heightSlider.value
            height /= 100
        }
      
        let imc = IMC(height: Float(height), weight: Float(weight))
        
        return imc
        
        
        
        }
    var str = "testing"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let destinationController = segue.destination as! ResultViewController
        destinationController.imc = calculate()
            
    }
            
        
}
    
        
    
    

class ResultViewController: UIViewController {
    
    var imc : ForthViewController.IMC?
    @IBOutlet weak var resultlbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        resultlbl.text = "\(Int(imc!.value)) : \(imc!.description)"
        view.backgroundColor = imc?.color
        
    }

    

}

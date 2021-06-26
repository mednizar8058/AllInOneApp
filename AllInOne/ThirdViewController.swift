//
//  ThirdViewController.swift
//  AllInOne
//
//  Created by MNizar on 6/20/21.
//  Copyright © 2021 MNizar. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var editView: UIView!
    @IBOutlet weak var textArea: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        textArea.layer.borderWidth = 1
        editView.isHidden = false

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var styleSeg: UISegmentedControl!
    
    @IBOutlet weak var emogiSeg: UISegmentedControl!
    
    @IBOutlet weak var colorSeg: UISegmentedControl!
    
    
    @IBAction func styleAction(_ sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex == 0){
            textArea.font = UIFont.boldSystemFont(ofSize: 16)
        }
        else if(sender.selectedSegmentIndex == 1){
            textArea.font = UIFont.italicSystemFont(ofSize: 16)
        }
        else{
            

        }
    }
    
    
    @IBAction func emogiAction(_ sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex == 0){
            textArea.insertText("😂")
        }
        else if(sender.selectedSegmentIndex == 1){
            textArea.insertText("😎")
        }
        else{
            textArea.insertText("😰")

        }
    }
    
    @IBAction func colorAction(_ sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex == 0){
            textArea.textColor = UIColor.black

        }
        else if(sender.selectedSegmentIndex == 1){
            textArea.textColor = UIColor.blue
        }
        else{
            textArea.textColor = UIColor.red
        }
    }
    
    
    @IBAction func fontAction(_ sender: UIStepper) {
        textArea.font = UIFont(name: (textArea.font?.fontName)!, size: CGFloat( sender.value))
    }
    
    @IBAction func hideEditor(_ sender: UISwitch) {
        if sender.isOn{
            editView.isHidden = true
            return
        }
        editView.isHidden = false
        
    }
    
    
}

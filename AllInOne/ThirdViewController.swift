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
    
    @IBOutlet weak var visualiseArea: UILabel!
    
    
    @IBOutlet weak var settingsView: UIView!
    @IBOutlet weak var contrainte: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textArea.layer.borderWidth = 1

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var fontStepper: UIStepper!
    
    @IBOutlet weak var styleSeg: UISegmentedControl!
    
    @IBOutlet weak var emogiSeg: UISegmentedControl!
    
    @IBOutlet weak var colorSeg: UISegmentedControl!
    
    
    @IBAction func clear(_ sender: Any) {
        textArea.text = ""
    }
    
    @IBAction func visualiseAction(_ sender: Any) {
        if(styleSeg.selectedSegmentIndex == 2){
            let string = NSMutableAttributedString(string: textArea.text!)
            string.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: textArea.text.count))
            visualiseArea.attributedText = string
            
            
        }
        else{
            visualiseArea.text = textArea.text!
            visualiseArea.font = textArea.font
            visualiseArea.textColor = textArea.textColor
        }
    }
    
    
    
    @IBAction func styleAction(_ sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex == 0){
            textArea.font = UIFont.boldSystemFont(ofSize: CGFloat(fontStepper!.value))
        }
        else if(sender.selectedSegmentIndex == 1){
            textArea.font = UIFont.italicSystemFont(ofSize: CGFloat(fontStepper!.value))
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
        textArea.font = UIFont.systemFont(ofSize: CGFloat(sender.value))
    }
    
    @IBAction func hideEditor(_ sender: UISwitch) {
        if sender.isOn{
            settingsView.isHidden = true
            contrainte.constant = 20
            return
        }
        contrainte.constant = 254
        settingsView.isHidden = false
        
    }
    
    
}

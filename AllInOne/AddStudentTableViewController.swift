//
//  AddStudentTableViewController.swift
//  AllInOne
//
//  Created by MNizar on 6/23/21.
//  Copyright © 2021 MNizar. All rights reserved.
//

import UIKit

class AddStudentTableViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var fname: UITextField!
    @IBOutlet weak var lname: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var dateInput: UITextField!
    @IBOutlet weak var cityInput: UITextField!
    
    let datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImg.layer.cornerRadius = 50
        createDatePicker()

        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }
    
    // to present the uiimagepicker
    @IBAction func editProfileImg(_ sender: UIButton) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        present(controller, animated: true, completion: nil)
    }
    
    
    // when the user tap cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //when an image is picked from the gallery
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let img = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        profileImg.image = img
        dismiss(animated: true, completion: nil)
    }
    
    func createDatePicker(){
        
        datePicker.datePickerMode = .date
        
        //toolbar to hold Done button
        let toolbar = UIToolbar()
        toolbar.sizeToFit();
        
        //bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(didTapDone))
        
        //assign done btn to toolbar
        toolbar.setItems([doneBtn], animated: true)
        
        //assign toolbar
        dateInput.inputAccessoryView = toolbar
        
        //assign datepicker
        dateInput.inputView = datePicker
        
    }
    
    
    
    @objc func didTapDone(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-YYYY"
    
        dateInput.text = "\(dateFormatter.string(from: datePicker.date))"
        self.view.endEditing(true)
        
    }
    
    @IBAction func createNewStudent(){
        let student = Student(context:context)
        student.fname = fname.text
        student.lname = lname.text
        student.age = age.text
        student.profileImg = profileImg.image?.pngData()
        student.birthDate = dateInput.text
        student.birthCity = cityInput.text
        
        do{
            students.append(student)
            try! context.save()
            let alert = UIAlertController(title: "Student Management", message: "Student has been added", preferredStyle: .alert)
            let btn = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(btn)
            present(alert, animated: true)
            
            
            cancel()
        }
        
        
        
        
    }
    
    @IBAction func cancel(){
        fname.text = ""
        lname.text = ""
        age.text = ""
        dateInput.text = ""
        profileImg.image = UIImage(systemName: "person.circle.fill")
        cityInput.text = ""
    }

}

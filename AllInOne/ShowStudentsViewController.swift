//
//  ShowStudentsViewController.swift
//  AllInOne
//
//  Created by MNizar on 6/23/21.
//  Copyright © 2021 MNizar. All rights reserved.
//

import UIKit
import CoreData


var students = [Student]()

class ShowStudentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    
    let dateFormatter = DateFormatter()
    let datePicker = UIDatePicker()
    
    @IBOutlet weak var showBtn: UITabBarItem!
    
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var searchInput: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! StudentTableViewCell
        cell.fullName.text = "\(students[indexPath.row].fname!) \(students[indexPath.row].lname!)"
        cell.age.text = "\(students[indexPath.row].age!)"
        dateFormatter.dateFormat = "yyyy-MM-dd"

        cell.birthDate.text = dateFormatter.string(from: students[indexPath.row].birthDate!)
        
        cell.birthPlace.text = "\(students[indexPath.row].birthCity!)"
        cell.profileImg.image = UIImage(data: students[indexPath.row].profileImg! as Data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 156
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            
            
            do{
            let student = students[indexPath.row]
                context.delete(student)
                students.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadData()
                try context.save()
            }catch{
                print("error while deleting student")
            }
        }
        

        let update = UITableViewRowAction(style: .normal, title: "Update") { (action, indexPath) in
            // update item at indexPath
            let alert = UIAlertController(title: "Student Management", message: "Updating Student", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let edit = UIAlertAction(title: "Update Student", style: .default, handler: {action -> Void in
                let student = students[indexPath.row]
                student.fname = alert.textFields![0].text
                student.lname = alert.textFields![1].text
                student.age = alert.textFields![2].text
                self.dateFormatter.dateFormat = "yyyy-MM-dd"
                
                student.birthDate = self.dateFormatter.date(from: alert.textFields![3].text! )
                student.birthCity = alert.textFields![4].text
                
                try! context.save()
                tableView.reloadData()
            
            }
            )
            
            
            alert.addAction(edit)
            alert.addAction(cancel)
            alert.addTextField()
            alert.addTextField()
            alert.addTextField()
            alert.addTextField{(textfield : UITextField)->Void in
                textfield.addTarget(self, action: #selector(self.justDateMode(sender:)), for: .editingDidBegin)
                
                textfield.addTarget(self, action: #selector(self.getDateFromDatePicker(sender:)), for: .editingDidEnd)
                //toolbar to hold Done button
                let toolbar = UIToolbar()
                toolbar.sizeToFit()
                
                let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: textfield, action: #selector(textfield.endEditing(_:)))
                
                //assign done btn to toolbar
                toolbar.setItems([doneBtn], animated: true)
                //assign toolbar
                textfield.inputAccessoryView = toolbar
            }
            
            alert.addTextField()
            
            alert.textFields![0].text = students[indexPath.row].fname
            alert.textFields![1].text = students[indexPath.row].lname
            alert.textFields![2].text = students[indexPath.row].age
            self.dateFormatter.dateFormat = "yyyy-MM-dd"
            alert.textFields![3].text = self.dateFormatter.string(from: students[indexPath.row].birthDate!)
            alert.textFields![4].text = students[indexPath.row].birthCity
            
            
            
            
           
            self.present(alert, animated: true)
        
        }
        
    
        update.backgroundColor = .gray
       
        return [ delete,update]
    }
    
    @objc func getDateFromDatePicker(sender:UITextField){
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
        
            sender.text = "\(dateFormatter.string(from: datePicker.date))"
            self.view.endEditing(true)
    }
    
    @objc func justDateMode(sender:UITextField){
        
        datePicker.datePickerMode = .date
        
        
        
        //assign datepicker
        sender.inputView = datePicker
        
        
    }
    /*func create(){
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
            
            //toolbar to hold Done button
            let toolbar = UIToolbar()
            toolbar.sizeToFit();
            
            //bar button
            let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
            
            //assign done btn to toolbar
            toolbar.setItems([doneBtn], animated: true)
            
            //assign toolbar
            alert.textFields![3].inputAccessoryView = toolbar
            
            //assign datepicker
            alert.textFields![3].inputView = datePicker
    }*/
        
        
        
       
    
    
    /*func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let student = students[indexPath.row]
            do{
                try{
                    context.delete(student)
                    context.save()
                }
                
            }catch{
                print("error")
            }
            students.remove(at: indexPath.row)
            loadData()
        }
    }*/
    
    func loadData(){
        print("loading data")

        let request:NSFetchRequest<Student> = Student.fetchRequest()
        
        //request.predicate = NSPredicate(format: "lname = %@", "test")
        do{
            let result = try! context.fetch(request)
            
            
            
                for x in result{
                    if x.fname != nil{
                        students.append(x)
                    }
                }
                
            
            
            tableView.reloadData()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    @IBAction func searchAction(_ sender: Any) {
        let request = NSFetchRequest<Student>(entityName: "Student")
        
        request.predicate = NSPredicate(format: "lname = %@", searchInput.text!)
        do{
            let result = try! context.fetch(request)
            if !result.isEmpty{
                let alert = UIAlertController(title: "Student Management", message: "Student exists", preferredStyle: .alert)
                let btn = UIAlertAction(title: "ok", style: .default, handler: nil)
                alert.addAction(btn)
                present(alert, animated: true)
            }
            
            else{
               let alert = UIAlertController(title: "Student Management", message: "Student doesn't exists", preferredStyle: .alert)
                let btn = UIAlertAction(title: "ok", style: .default, handler: nil)
                alert.addAction(btn)
                present(alert, animated: true)
            }
            
            
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        let deleterequ = NSBatchDeleteRequest(fetchRequest: request)
        
        try! context.execute(deleterequ)*/
        

        if students.count == 0{
            loadData()
        }
        showBtn.badgeValue = "test"
        
        
        
        

        // Do any additional setup after loading the view.
    }
    

    

}

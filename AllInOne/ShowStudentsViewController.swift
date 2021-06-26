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
        cell.birthDate.text = "\(students[indexPath.row].birthDate!)"
        cell.birthPlace.text = "\(students[indexPath.row].birthCity!)"
        cell.profileImg.image = UIImage(data: students[indexPath.row].profileImg! as Data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 156
    }
    
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
        

        
        loadData()
        showBtn.badgeValue = "test"
        
        
        
        

        // Do any additional setup after loading the view.
    }
    

    

}

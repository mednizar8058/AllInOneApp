//
//  ShowStudentsViewController.swift
//  AllInOne
//
//  Created by MNizar on 6/23/21.
//  Copyright © 2021 MNizar. All rights reserved.
//

import UIKit


class ShowStudentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var students = [Student(context:context)]
    
    
    
    @IBOutlet weak var showBtn: UITabBarItem!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! StudentTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 189
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showBtn.badgeValue = "test"
        let student = Student(context: context)
        student.fname = "test"
        students.append(student)
        
        //print(students[0].fname!)

        // Do any additional setup after loading the view.
    }
    

    

}

//
//  UserDefaultViewController.swift
//  AllInOne
//
//  Created by MNizar on 6/28/21.
//  Copyright © 2021 MNizar. All rights reserved.
//

import UIKit

struct student:Codable {
    var fname:String
    var lname:String
    var profileImg:Data
}

var studentList = [student]()

class UserDefaultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var myTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UserDefaultTableViewCell
        
        cell.fname.text = studentList[indexPath.row].fname
        cell.lname.text = studentList[indexPath.row].lname
        cell.profileImg.image = UIImage(data: studentList[indexPath.row].profileImg)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 164
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
    if editingStyle == .delete{
        studentList.remove(at: indexPath.row)
        UserDefaults.standard.set(try? PropertyListEncoder().encode(studentList), forKey: "students")
        myTableView.reloadData()
    }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        myTableView.reloadData()
      
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if let loadedData = UserDefaults.standard.object(forKey: "students"){
            
                studentList = try! PropertyListDecoder().decode([student].self, from: loadedData as! Data)
            
                myTableView.reloadData()
        }
        
        myTableView.layer.cornerRadius = 30
        // Do any additional setup after loading the view.
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

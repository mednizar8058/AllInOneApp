//
//  Student.swift
//  AllInOne
//
//  Created by MNizar on 6/23/21.
//  Copyright © 2021 MNizar. All rights reserved.
//

import UIKit

class fStudent:NSObject{
    
    var fname:String
    var lname:String
    var age:String
    var birthDate:String
    var birthPlace:String
    
    init(fname:String,lname:String,age:String,birthDate:String,birthPlace:String) {
        self.fname = fname
        self.lname = lname
        self.age = age
        self.birthDate = birthDate
        self.birthPlace = birthPlace
    }
}

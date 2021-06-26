//
//  StudentTableViewCell.swift
//  AllInOne
//
//  Created by MNizar on 6/23/21.
//  Copyright © 2021 MNizar. All rights reserved.
//

import UIKit

class StudentTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var birthDate: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var birthPlace: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellView.layer.cornerRadius = 30
        profileImg.layer.cornerRadius = 50
        fullName.text = "mochir mohammed nizar ggg"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

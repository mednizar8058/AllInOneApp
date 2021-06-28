//
//  UserDefaultTableViewCell.swift
//  AllInOne
//
//  Created by MNizar on 6/28/21.
//  Copyright © 2021 MNizar. All rights reserved.
//

import UIKit

class UserDefaultTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var fname: UILabel!
    @IBOutlet weak var lname: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.layer.cornerRadius = 30
        profileImg.layer.cornerRadius = 37
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

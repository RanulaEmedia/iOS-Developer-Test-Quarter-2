//
//  UserTVCell.swift
//  Training-iOS-DataSources
//
//  Created by Dushan Saputhanthri on 9/6/20.
//  Copyright © 2020 Elegant Media Pvt Ltd. All rights reserved.
//

import UIKit

class UserTVCell: UITableViewCell {
    
    @IBOutlet weak var lblFirstname: UILabel!
    @IBOutlet weak var lblLastname: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(with model: User ) {
        lblFirstname.text = model.firstName ?? ""
        lblLastname.text = model.lastName ?? ""
        lblEmail.text = model.email ?? ""
    }
    
}

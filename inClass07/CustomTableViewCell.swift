//
//  CustomTableViewCell.swift
//  inClass07
//
//  Created by Stone, Brian on 6/17/19.
//  Copyright © 2019 Stone, Brian. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    var id:Int?
    
    @IBAction func deleteButton(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("deleteContact"), object: self.id!)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

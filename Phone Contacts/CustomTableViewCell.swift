//
//  CustomTableViewCell.swift
//  Phone Contacts
//
//  Created by Eang Pheara on 1/4/17.
//  Copyright © 2017 Eang Pheara. All rights reserved.
//

import UIKit
import CoreData

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
   
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(contact: Contact){
        
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
        
        self.nameLabel.text = contact.name
        self.phoneLabel.text = contact.phone
        self.emailLabel.text = contact.email
        self.profileImageView.image = UIImage(named: contact.image!)
        print("Contact Image URL \(contact.image)")
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

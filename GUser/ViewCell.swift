//
//  ViewCell.swift
//  GUser
//
//  Created by Wei Kuo on 2020/2/23.
//  Copyright © 2020 Wei Kuo. All rights reserved.
//

import UIKit

class ViewCell: UITableViewCell {

    @IBOutlet var nameLabel:UILabel!
    @IBOutlet var picImageView:UIImageView!
    @IBOutlet var starImageView:UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = ""
        picImageView.image = nil
        let size = picImageView.frame.size
        picImageView.layer.cornerRadius = size.height / 2
        starImageView.isHidden = true
    }
}

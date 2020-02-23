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
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        let size = picImageView.frame.size
        picImageView.layer.cornerRadius = size.height / 2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = ""
        picImageView.image = nil
        starImageView.isHidden = true
    }
}

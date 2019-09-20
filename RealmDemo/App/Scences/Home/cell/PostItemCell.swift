//
//  PostItemCell.swift
//  RealmDemo
//
//  Created by Kyaw Kyaw Khing on 9/19/19.
//  Copyright © 2019 Kyaw Kyaw Khing. All rights reserved.
//

import UIKit

class PostItemCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(with data:PostItemViewModel){
        self.titleLabel.text = data.title
        self.detailsLabel.text = data.subtitle
    }
}

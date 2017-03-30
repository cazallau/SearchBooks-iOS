//
//  BookCell.swift
//  Books
//
//  Created by Gema Beltran on 30/3/17.
//  Copyright © 2017 Antonio Jesus Cazalla. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell {
    @IBOutlet weak var imageBook: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

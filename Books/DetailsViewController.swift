//
//  DetailsViewController.swift
//  Books
//
//  Created by Antonio Jesus Cazalla Ureña on 31/3/17.
//  Copyright © 2017 Antonio Jesus Cazalla. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var imageBook: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var detailText: UITextView!
    var book: Book = Book()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = book.title
        APIDownloadImage.downloadImage(book.image, inView: imageBook)
        authorLabel.text = book.author
        dateLabel.text = book.date
        detailText.text = book.descripcion
    }
}


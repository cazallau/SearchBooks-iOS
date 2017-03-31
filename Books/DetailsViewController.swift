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

        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 50))
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = book.title
        self.navigationItem.titleView = label
        ImageDownloader.downloadImage(book.image, inView: imageBook)
        authorLabel.text = book.author
        dateLabel.text = book.date
        detailText.text = book.descripcion
    }
}


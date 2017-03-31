//
//  BookTableViewController.swift
//  Books
//
//  Created by Antonio Jesus Cazalla Ureña on 30/3/17.
//  Copyright © 2017 Antonio Jesus Cazalla. All rights reserved.
//

import UIKit

class BookTableViewController: UITableViewController {
    var listBook: [Book] = []
    var searchController: UISearchController!
    let apiClient: APICLient = APICLient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        self.searchController = UISearchController(searchResultsController: nil)
        self.tableView.tableHeaderView = self.searchController.searchBar
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.dimsBackgroundDuringPresentation = false
        search(name: "Eventos")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails"{
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let destinationController = segue.destination as! DetailsViewController
                destinationController.book = self.listBook[indexPath.row]
                let backItem = UIBarButtonItem()
                backItem.title = "Back"
                destinationController.navigationItem.backBarButtonItem = backItem
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listBook.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath) as! BookCellView
        let book = self.listBook[indexPath.row]
        APIDownloadImage.downloadImage(book.image, inView: cell.imageBook)
        cell.titleLabel.text = book.title
        cell.authorLabel.text = book.author

        return cell
    }
}

private extension BookTableViewController {
    
    func search(name: String) {
        apiClient.search(name: name) { books in
            self.listBook = books
            self.tableView.reloadData()
        }
    }
}

extension BookTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {

        if let searchText = searchController.searchBar.text {
            search(name: searchText)
        }
    }
}

extension BookTableViewController: UISearchControllerDelegate {
    func didDismissSearchController(_ searchController: UISearchController) {
        search(name: "eventos")
    }
}



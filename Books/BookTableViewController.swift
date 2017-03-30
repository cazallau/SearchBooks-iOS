//
//  BookTableViewController.swift
//  Books
//
//  Created by Gema Beltran on 30/3/17.
//  Copyright © 2017 Antonio Jesus Cazalla. All rights reserved.
//

import UIKit

class BookTableViewController: UITableViewController {
    var listBook : [Book] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        search(name: "50")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.listBook.count
    }
    
    
    
}

private extension BookTableViewController {
    
    func search(name : String){
        let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=" + name)
        
        URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            if(error != nil){
                print("error")
            }else{
                do{
                    
                    
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
                    
                    if let books = json["items"] as? [[String: AnyObject]]{
                        for books in books {
                            var newBook: Book = Book()
                            
                            if let volum = books["volumeInfo"] as? [String : AnyObject] {
                                newBook.title = volum["title"] as? String
                                newBook.descripcion = volum["description"] as? String
                                
                                if let author = volum["authors"] as? [String]{
                                    var auth = ""
                                    for author in author {
                                        auth = auth + (author as? String)! + ","
                                    }
                                    newBook.author = auth
                                }
                                
                                if let image = volum["imageLinks"] as? [String : AnyObject] {
                                    
                                    newBook.image = image["thumbnail"] as? String
                                }
                                
                                newBook.date = volum["publishedDate"] as? String
                                
                            }
                            self.listBook.append(newBook)
                        }
                    }
                    
                    OperationQueue.main.addOperation({
                        //print(json["products"])
                        
                    })
                    
                }catch let error as NSError{
                    print(error)
                }
            }
        }).resume()
        
    }
}



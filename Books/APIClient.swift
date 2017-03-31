//
//  APIClient.swift
//  Books
//
//  Created by Gema Beltran on 31/3/17.
//  Copyright © 2017 Antonio Jesus Cazalla. All rights reserved.
//

import Foundation

class APICLient {
    func search(name: String, completion: @escaping ([Book]) -> ()) {
        let searchName = name.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
        guard let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=" + searchName) else {
            print("Wrong URL")
            completion([])
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: {
            (data, response, error) in
            guard error == nil else {
                print("error")
                return
            }
            
            let books = self.getBooks(fromData: data)
            OperationQueue.main.addOperation {
                completion(books)
            }
        }).resume()
    }
    
    func getBooks(fromData data: Data?) -> [Book] {
        var listBook: [Book] = []
        guard let data = data else {
            return listBook
        }
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: AnyObject]
            
            if let books = json["items"] as? [[String: AnyObject]] {
                for book in books {
                    let newBook: Book = Book()
                    
                    if let volume = book["volumeInfo"] as? [String: AnyObject] {
                        newBook.title = volume["title"] as? String
                        newBook.descripcion = volume["description"] as? String
                        
                        if let authors = volume["authors"] as? [String] {
                            var auth = ""
                            for author in authors {
                                auth = auth + (author) + ","
                            }
                            newBook.author = auth
                        }
                        
                        if let image = volume["imageLinks"] as? [String: AnyObject] {
                            
                            newBook.image = image["thumbnail"] as? String
                        }
                        
                        newBook.date = volume["publishedDate"] as? String
                    }
                    listBook.append(newBook)
                }
            }
        } catch let error as NSError {
            print(error)
        }
        
        return listBook
    }
    
}

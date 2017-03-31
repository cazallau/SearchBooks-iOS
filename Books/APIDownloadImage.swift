//
//  APIDownloadImage.swift
//  Books
//
//  Created by Antonio Jesus Cazalla Ureña on 31/3/17.
//  Copyright © 2017 Antonio Jesus Cazalla. All rights reserved.
//

import Foundation
import UIKit

class APIDownloadImage {
    static func downloadImage(_ uri: String?, inView: UIImageView) {
        guard let uri = uri, let url = URL(string: uri) else {
            print("😱 Error in url")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { responseData, response, error in
            guard error == nil, let data = responseData else {
                print("Error")
                return
            }
            
            DispatchQueue.main.async {
                inView.image = UIImage(data: data)
            }
        }
        
        task.resume()
    }
}

//
//  APIService.swift
//  CachingImages
//
//  Created by xcismans on 08/10/2021.
//

import UIKit

class APIService: NSObject {
    
    var mainURL : URL?
    
    func setPagingForSourceURL(page: String){
        let sourceString = "https://picsum.photos/v2/list?page=1&limit=" + page
        let sourceURL = URL(string: sourceString)
        mainURL = sourceURL
    }
    
    
    func apiToGetPhotosData(pageNum: String,completion : @escaping ([PhotosData]) -> ()){
        setPagingForSourceURL(page: pageNum)
        URLSession.shared.dataTask(with: mainURL!) { (data, urlResponse, error) in
            if let data = data {
                
                let jsonDecoder = JSONDecoder()
                
                let photosData = try! jsonDecoder.decode([PhotosData].self, from: data)
            
                    completion(photosData)
            }
            
        }.resume()
    }
}
